package player

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	dbops "github.com/ldzzz/kacky-gameserver-backend/database"
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
	_ = playerGroup.AddEndpoint("finish", micro.HandlerFunc(playerFinish))
	_ = playerGroup.AddEndpoint("setName", micro.HandlerFunc(playerSetNickname))
	_ = playerGroup.AddEndpoint("addStreamer", micro.HandlerFunc(playerAddStreamer))
	_ = playerGroup.AddEndpoint("setStreamStatus", micro.HandlerFunc(playerStreamStatus))
	//_ = playersGroup.AddEndpoint("setTags", micro.HandlerFunc(playerSetTags))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func playerConnect(req micro.Request) {
	var pd PlayerConnect
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// insert player if it doesn't exist, else update nickname and zone on connect
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), dbops.CreateUpdatePlayerParams{Login: pd.Login, Nickname: sql.NullString{String: pd.Nickname, Valid: true}, Zone: sql.NullString{String: pd.Zone, Valid: true}, GameType: pd.GameType}); err != nil {
		slog.Error("Failed to create or update player", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = getPlayerCombined(pd.Login, pd.GameType, true, true); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerSetNickname(req micro.Request) {
	var pd PlayerNickname
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// update player nickname
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), dbops.CreateUpdatePlayerParams{Login: pd.Login, Nickname: sql.NullString{String: pd.Nickname, Valid: true}, GameType: pd.GameType}); err != nil {
		slog.Error("Failed to create or update player nickname", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = getPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerAddStreamer(req micro.Request) {
	var pd PlayerStreamerData
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// get the player data
	var fetchedPlayer *dbops.TmPlayer
	if fetchedPlayer, err = getPlayer(pd.Login, pd.GameType); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// create/update streamer metadata
	sd := PlayerStreamData{&pd.Platform, &pd.StreamerLogin, pd.StreamStatus}

	var streamerData json.RawMessage
	if streamerData, err = json.Marshal(sd); err != nil {
		slog.Error("Unable to marshal streamer data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	if err = createUpdateStreamer(pd.GameType, fetchedPlayer.ID, streamerData); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// set role as streamer
	if err = config.ENV.DB.SetPlayerRole(context.Background(), dbops.SetPlayerRoleParams{Role: "streamer", Login: pd.Login, GameType: pd.GameType}); err != nil {
		slog.Error("Unable to set player role to streamer", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = getPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerStreamStatus(req micro.Request) {
	var pd PlayerStreamerStatus
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// get the player data
	var fetchedPlayer *dbops.TmPlayer
	if fetchedPlayer, err = getPlayer(pd.Login, pd.GameType); err != nil {
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
	var playerMetadata *dbops.UserMetadatum
	if playerMetadata, err = getPlayerMetadata(fetchedPlayer.ID); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	if playerMetadata == nil || playerMetadata.StreamData == nil {
		slog.Info("Unknown streamer setting status")
		_ = req.RespondJSON(&utils.RequestError{Code: 404, Message: "User has no stream information"})
		return
	}

	// get stream data
	var sd PlayerStreamData
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

	if err = createUpdateStreamer(pd.GameType, fetchedPlayer.ID, streamerData); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	var combinedPlayerData any
	if combinedPlayerData, err = getPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
}

func playerFinish(req micro.Request) { //TODO: how to handle player ranks, and e.g. differences on PB and stuff ????
	var pd PlayerFinish
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// process player finish data
	if err = processPlayerFinish(pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// return player metadata
	var combinedPlayerData any
	if combinedPlayerData, err = getPlayerCombined(pd.Login, pd.GameType, true, true); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(pd), utils.PrettyPrint(combinedPlayerData)))
	_ = req.RespondJSON(combinedPlayerData)
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
