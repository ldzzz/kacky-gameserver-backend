package player

import (
	"context"
	"database/sql"
	"encoding/json"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	dbops "github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
)

func getPlayer(login string, gameType string) (*dbops.TmPlayer, error) {
	var fetchedPlayer dbops.TmPlayer
	var err error

	if fetchedPlayer, err = config.ENV.DB.GetPlayer(context.Background(), dbops.GetPlayerParams{Login: login, GameType: gameType}); err != nil {
		slog.Error("Failed to get player", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	return &fetchedPlayer, nil
}

func getPlayerMetadata(id int64) (*dbops.UserMetadatum, error) {
	var playerMetadata dbops.UserMetadatum
	var err error
	if playerMetadata, err = config.ENV.DB.GetPlayerMetadata(context.Background(), dbops.GetPlayerMetadataParams{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}}); err != nil && err != sql.ErrNoRows {
		slog.Error("Failed to get player metadata", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	return &playerMetadata, nil
}

func createUpdateStreamer(gameType string, id int64, streamData json.RawMessage) error {
	var err error
	if gameType == "KR" {
		err = config.ENV.DB.CreateUpdateStreamDataTM20(context.Background(), dbops.CreateUpdateStreamDataTM20Params{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	} else {
		err = config.ENV.DB.CreateUpdateStreamDataTMNF(context.Background(), dbops.CreateUpdateStreamDataTMNFParams{TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	}
	if err != nil {
		slog.Error("Failed to create/update player stream data", "error", err)
		return utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}
	return nil

}

func getPlayerCombined(login string, gameType string, includeMetadata bool, includeFinishes bool) (*any, error) {
	// get the player data to return on connect
	var fetchedPlayer *dbops.TmPlayer
	var playerMetadata *dbops.UserMetadatum
	var playerFinishes []dbops.GetPlayerFinishesRow
	var err error

	if fetchedPlayer, err = getPlayer(login, gameType); err != nil {
		return nil, err
	}

	// get metadata (to obtain stream data)
	if includeMetadata {
		if playerMetadata, err = getPlayerMetadata(fetchedPlayer.ID); err != nil {
			slog.Error("Failed to get player metadata", "error", err)
			return nil, err
		}
	}

	//get finishes
	if includeFinishes {
		if playerFinishes, err = config.ENV.DB.GetPlayerFinishes(context.Background(), dbops.GetPlayerFinishesParams{Login: login, GameType: gameType}); err != nil && err != sql.ErrNoRows {
			slog.Error("Failed to get player finishes", "error", err)
			return nil, &utils.RequestError{Code: 500, Message: "Internal Server Error"}
		}
	}

	var combinedPlayerData any
	if includeMetadata && includeFinishes {
		combinedPlayerData = struct {
			*dbops.TmPlayer
			StreamData *json.RawMessage             `json:"streamData"`
			Records    []dbops.GetPlayerFinishesRow `json:"records"`
		}{fetchedPlayer, playerMetadata.StreamData, playerFinishes}
	} else if includeMetadata {
		combinedPlayerData = struct {
			*dbops.TmPlayer
			StreamData *json.RawMessage `json:"streamData"`
		}{fetchedPlayer, playerMetadata.StreamData}
	} else if includeFinishes {
		combinedPlayerData = struct {
			*dbops.TmPlayer
			Records []dbops.GetPlayerFinishesRow `json:"records"`
		}{fetchedPlayer, playerFinishes}
	} else {
		panic("No combined data needed, you should use getPlayer()")
	}

	return &combinedPlayerData, nil
}

func processPlayerFinish(pd PlayerFinish) error {
	var err error
	// get the player data
	var fetchedPlayer *dbops.TmPlayer
	if fetchedPlayer, err = getPlayer(pd.Login, pd.GameType); err != nil {
		return err
	}

	// store or update player finish data
	if err = config.ENV.DB.CreateUpdatePlayerMapFinish(context.Background(), dbops.CreateUpdatePlayerMapFinishParams{MapUid: pd.MapUid, PlayerID: fetchedPlayer.ID, Score: pd.Score, LastImprovedAt: pd.Timestamp}); err != nil {
		slog.Error("Couldn't update player finish data", "error", err)
		return err
	}

	return nil
}
