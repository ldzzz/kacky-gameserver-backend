package apihelpers

import (
	"context"
	"database/sql"
	"encoding/json"
	"log/slog"
	"slices"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/ldzzz/kacky-gameserver-backend/database"
	db "github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
)

func GetPlayer(login string, gameType string) (*db.TmPlayer, error) {
	var fetchedPlayer *db.TmPlayer
	var err error

	if fetchedPlayer, err = config.ENV.DB.GetPlayer(context.Background(), db.GetPlayerParams{Login: login, GameType: gameType}); err != nil {
		slog.Error("Failed to get player", "error", err)
		return nil, utils.RequestError{Code: 404, Message: "Player not found"}
	}

	return fetchedPlayer, nil
}

func GetPlayerMetadata(id int64) (*db.UserMetadatum, error) {
	var playerMetadata *db.UserMetadatum
	var err error
	if playerMetadata, err = config.ENV.DB.GetPlayerMetadata(context.Background(), db.GetPlayerMetadataParams{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}}); err != nil && err != sql.ErrNoRows {
		slog.Error("Failed to get player metadata", "error", err)
		return nil, utils.RequestError{Code: 404, Message: "Player not found"}
	}

	return playerMetadata, nil
}

func CreateUpdateStreamer(gameType string, id int64, streamData json.RawMessage) error {
	var err error
	if gameType == "KR" {
		err = config.ENV.DB.CreateUpdateStreamDataTM20(context.Background(), db.CreateUpdateStreamDataTM20Params{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	} else {
		err = config.ENV.DB.CreateUpdateStreamDataTMNF(context.Background(), db.CreateUpdateStreamDataTMNFParams{TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	}
	if err != nil {
		slog.Error("Failed to create/update player stream data", "error", err)
		return utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}
	return nil

}

func GetPlayerCombined(login string, gameType string, includeMetadata bool, includeFinishes bool) (*any, error) {
	// get the player data to return on connect
	var fetchedPlayer *db.TmPlayer
	var playerMetadata *db.UserMetadatum
	var playerFinishes []*db.GetPlayerFinishesRow
	var err error

	if fetchedPlayer, err = GetPlayer(login, gameType); err != nil {
		return nil, err
	}

	// get metadata (to obtain stream data)
	if includeMetadata {
		if playerMetadata, err = GetPlayerMetadata(fetchedPlayer.ID); err != nil {
			slog.Error("Failed to get player metadata", "error", err)
			return nil, err
		}
	}

	//get finishes
	if includeFinishes {
		if playerFinishes, err = config.ENV.DB.GetPlayerFinishes(context.Background(), db.GetPlayerFinishesParams{Login: login, GameType: gameType}); err != nil && err != sql.ErrNoRows {
			slog.Error("Failed to get player finishes", "error", err)
			return nil, &utils.RequestError{Code: 500, Message: "Internal Server Error"}
		}
	}

	var combinedPlayerData any
	if includeMetadata && includeFinishes {
		combinedPlayerData = struct {
			*db.TmPlayer
			StreamData *json.RawMessage           `json:"streamData"`
			Records    []*db.GetPlayerFinishesRow `json:"records"`
		}{fetchedPlayer, playerMetadata.StreamData, playerFinishes}
	} else if includeMetadata {
		combinedPlayerData = struct {
			*db.TmPlayer
			StreamData *json.RawMessage `json:"streamData"`
		}{fetchedPlayer, playerMetadata.StreamData}
	} else if includeFinishes {
		combinedPlayerData = struct {
			*db.TmPlayer
			Records []*db.GetPlayerFinishesRow `json:"records"`
		}{fetchedPlayer, playerFinishes}
	} else {
		panic("No combined data needed, you should use getPlayer()")
	}

	return &combinedPlayerData, nil
}

func ProcessPlayerFinish(pd PlayerFinish) (*PlayerFinishInfo, error) {
	var err error

	// check if map exists
	if _, err = config.ENV.DB.GetMapByUid(context.Background(), pd.MapUid); err != nil {
		return nil, &utils.RequestError{Code: 400, Message: "MapUID doesnt exist"}
	}

	// get the player data
	var fetchedPlayer *db.TmPlayer
	if fetchedPlayer, err = GetPlayer(pd.Login, pd.GameType); err != nil {
		return nil, err
	}

	//get map leaderboard before insert
	var oldRecords []*database.GetMapSortedRecordsRow
	if oldRecords, err = config.ENV.DB.GetMapSortedRecords(context.Background(), pd.MapUid); err != nil {
		slog.Error("Couldn't retrieve map records", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	// store or update player finish data
	if err = config.ENV.DB.CreateUpdatePlayerMapFinish(context.Background(), db.CreateUpdatePlayerMapFinishParams{MapUid: pd.MapUid, PlayerID: fetchedPlayer.ID, Score: pd.Score, LastImprovedAt: pd.Timestamp}); err != nil {
		slog.Error("Couldn't update player finish data", "error", err)
		return nil, err
	}

	// get map leaderboard after finish
	var newRecords []*database.GetMapSortedRecordsRow
	if newRecords, err = config.ENV.DB.GetMapSortedRecords(context.Background(), pd.MapUid); err != nil {
		slog.Error("Couldn't retrieve map records", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	oldRank := slices.IndexFunc(oldRecords, func(c *database.GetMapSortedRecordsRow) bool { return c.Login == pd.Login })
	newRank := slices.IndexFunc(newRecords, func(c *database.GetMapSortedRecordsRow) bool { return c.Login == pd.Login })

	// prepare finish info
	playerFinishInfo := PlayerFinishInfo{FinishType: "Finish", FinishRank: newRank + 1, FinishRankDifference: -1, FinishScoreDifference: -1}
	if oldRank == -1 { // new finish
		playerFinishInfo.FinishType = "NewFinish"
	} else if oldRecords[oldRank].Score > pd.Score { // PB
		playerFinishInfo.FinishType = "PersonalBest"
		playerFinishInfo.FinishRankDifference = oldRank - newRank
		playerFinishInfo.FinishScoreDifference = int(oldRecords[oldRank].Score - pd.Score)
	}

	return &playerFinishInfo, nil
}

func GetPlayerFinishCombined(login string, gameType string, finishRankInfo *PlayerFinishInfo) (*any, error) {
	// get the player data to return on connect
	var fetchedPlayer *db.TmPlayer
	var playerMetadata *db.UserMetadatum
	var playerFinishes []*db.GetPlayerFinishesRow
	var err error

	if fetchedPlayer, err = GetPlayer(login, gameType); err != nil {
		return nil, err
	}

	// get metadata (to obtain stream data)
	if playerMetadata, err = GetPlayerMetadata(fetchedPlayer.ID); err != nil {
		slog.Error("Failed to get player metadata", "error", err)
		return nil, err
	}

	//get finishes
	if playerFinishes, err = config.ENV.DB.GetPlayerFinishes(context.Background(), db.GetPlayerFinishesParams{Login: login, GameType: gameType}); err != nil && err != sql.ErrNoRows {
		slog.Error("Failed to get player finishes", "error", err)
		return nil, &utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	var combinedPlayerData any
	combinedPlayerData = struct {
		*db.TmPlayer
		StreamData *json.RawMessage           `json:"streamData"`
		FinishInfo PlayerFinishInfo           `json:"finishInfo"`
		Records    []*db.GetPlayerFinishesRow `json:"records"`
	}{fetchedPlayer, playerMetadata.StreamData, *finishRankInfo, playerFinishes}

	return &combinedPlayerData, nil
}
