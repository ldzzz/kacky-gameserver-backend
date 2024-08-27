package player

import (
	"context"
	"encoding/json"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	db "github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/ldzzz/kacky-gameserver-backend/internal/apihelpers"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
	"github.com/nats-io/nats.go/micro"
)

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "PlayerService",
		Version: "1.0.0",
	})
	playerGroup := srv.AddGroup("player")
	_ = playerGroup.AddEndpoint("connect", micro.HandlerFunc(playerConnect))
	_ = playerGroup.AddEndpoint("finish", micro.HandlerFunc(playerFinish)) // TODO: consider if rank should be calculated and included into the response or not
	_ = playerGroup.AddEndpoint("setName", micro.HandlerFunc(playerSetNickname))
	_ = playerGroup.AddEndpoint("setStreamStatus", micro.HandlerFunc(playerStreamStatus))
	//_ = playersGroup.AddEndpoint("setTags", micro.HandlerFunc(playerSetTags))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func playerConnect(req micro.Request) {
	var pd apihelpers.PlayerConnect
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// insert player if it doesn't exist, else update nickname and zone on connect
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), db.CreateUpdatePlayerParams{Login: pd.Login, Nickname: pd.Nickname, Zone: pd.Zone, GameType: pd.GameType}); err != nil {
		slog.Error("Failed to create or update player", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = apihelpers.GetPlayerCombined(pd.Login, pd.GameType, true, true); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerSetNickname(req micro.Request) {
	var pd apihelpers.PlayerNickname
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// update player nickname
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), db.CreateUpdatePlayerParams{Login: pd.Login, Nickname: pd.Nickname, GameType: pd.GameType}); err != nil {
		slog.Error("Failed to create or update player nickname", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = apihelpers.GetPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerStreamStatus(req micro.Request) {
	var pd apihelpers.PlayerStreamerStatus
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// get the player data
	var fetchedPlayer *db.TmPlayer
	if fetchedPlayer, err = apihelpers.GetPlayer(pd.Login, pd.GameType); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// check if streamer
	if fetchedPlayer.Role != "streamer" {
		slog.Info("Not a streamer, how could this happen?")
		_ = req.RespondJSON(&utils.RequestError{Code: 404, Message: "User doesn't have streamer role"})
		return
	}

	// get metadata (to obtain stream data)
	var playerMetadata *db.UserMetadatum
	if playerMetadata, err = apihelpers.GetPlayerMetadata(fetchedPlayer.ID); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	if playerMetadata == nil || playerMetadata.StreamData == nil {
		slog.Info("Unknown streamer setting status")
		_ = req.RespondJSON(&utils.RequestError{Code: 404, Message: "User has no stream information"})
		return
	}

	// get stream data
	var sd apihelpers.PlayerStreamData
	if err = utils.Deserialize(*playerMetadata.StreamData, &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// update stream status
	sd.StreamStatus = pd.StreamStatus
	var streamerData json.RawMessage
	if streamerData, err = json.Marshal(sd); err != nil {
		slog.Error("Unable to marshal streamer data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	if err = apihelpers.CreateUpdateStreamer(pd.GameType, fetchedPlayer.ID, streamerData); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = apihelpers.GetPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerFinish(req micro.Request) {
	var pd apihelpers.PlayerFinish
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// process player finish data
	var finishRankInfo *apihelpers.PlayerFinishInfo
	if finishRankInfo, err = apihelpers.ProcessPlayerFinish(pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// return player finish combined data
	var combinedPlayerFinishData any
	if combinedPlayerFinishData, err = apihelpers.GetPlayerFinishCombined(pd.Login, pd.GameType, finishRankInfo); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerFinishData)))
	_ = req.RespondJSON(combinedPlayerFinishData)
}

/*
func playerSetTags(req micro.Request) {
	var pd PlayerConnect
	var err error

	if err = utils.Deserialize(req, &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
	slog.Debug(utils.PrettyPrint(pcon))
	_ = req.RespondJSON(pcon)
}
*/
