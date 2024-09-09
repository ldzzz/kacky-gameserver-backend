package admin

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
		Name:    "AdminService",
		Version: "1.0.0",
	})
	adminGroup := srv.AddGroup("admin")
	_ = adminGroup.AddEndpoint("addStreamer", micro.HandlerFunc(adminAddStreamer))
	_ = adminGroup.AddEndpoint("changeRole", micro.HandlerFunc(adminChangeRole))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func adminAddStreamer(req micro.Request) {
	var pd apihelpers.PlayerStreamerData
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

	// create/update streamer metadata
	sd := apihelpers.PlayerStreamData{Platform: &pd.Platform, StreamerLogin: &pd.StreamerLogin, StreamStatus: pd.StreamStatus}

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

func adminChangeRole(req micro.Request) {
	var pd apihelpers.AdminChangeRole
	var err error

	if err = utils.Deserialize(req.Data(), &pd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
	req.Subject()

	// update user role
	if err = config.ENV.DB.SetPlayerRole(context.Background(), db.SetPlayerRoleParams{Role: pd.Role, Login: pd.Login, GameType: pd.GameType}); err != nil {
		slog.Error("Unable to set player role", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	// return updated player data
	var playerData any
	if playerData, err = apihelpers.GetPlayerCombined(pd.Login, pd.GameType, true, false); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", utils.PrettyPrint(pd), utils.PrettyPrint(playerData)))
	_ = req.RespondJSON(playerData)
}
