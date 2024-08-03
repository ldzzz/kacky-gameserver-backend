package players

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/ldzzz/kacky-gameserver-backend/dbops"
	"github.com/ldzzz/kacky-gameserver-backend/utils/logging/helpers"
	"github.com/nats-io/nats.go/micro"
)

type DataSelector string

const (
	CONNECT  DataSelector = "connect"
	FINISH   DataSelector = "finish"
	NICKNAME DataSelector = "nickname"
	TAG      DataSelector = "tag"
)

type PlayerError struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
	//Error   error
}

func (err PlayerError) Error() string {
	ret, _ := json.Marshal(err)
	return string(ret)
}

type PlayerData struct {
	Login        *string `json:"login"`
	Nickname     *string `json:"nickname"`
	Zone         *string `json:"zone"`
	MapUid       *string `json:"mapUid"`
	Score        *int    `json:"score"`
	StreamStatus *bool   `json:"streamStatus"`
	Platform     *string `json:"platform"`
	StreamLogin  *string `json:"streamLogin"`
	GameType     *string `json:"gameType"`
}

// check if deserialized data received has necessary values for the given functionality
func (pd PlayerData) isValid(sel DataSelector) bool {
	switch sel {
	case CONNECT:
		return pd.Login != nil && pd.GameType != nil && pd.Zone != nil && pd.Nickname != nil
	case FINISH:
		return false
	case NICKNAME:
		return pd.Login != nil && pd.GameType != nil && pd.Nickname != nil
	}

	panic("No valid DataSelector provided, this shouldn't happen")
}

func (pd *PlayerData) Deserialize(req micro.Request) error {
	if err := json.Unmarshal(req.Data(), pd); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return PlayerError{400, "Deserialize failed"}
	}

	return nil
}

func (pd *PlayerData) String() string {
	s, _ := json.Marshal(pd)
	return fmt.Sprintln(string(s))
}

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "PlayersService",
		Version: "1.0.0",
	})
	playersGroup := srv.AddGroup("player")
	_ = playersGroup.AddEndpoint("connect", micro.HandlerFunc(playerConnect))
	_ = playersGroup.AddEndpoint("finish", micro.HandlerFunc(playerFinish))
	_ = playersGroup.AddEndpoint("setNickname", micro.HandlerFunc(playerSetNickname))
	_ = playersGroup.AddEndpoint("addStreamer", micro.HandlerFunc(playerAddStreamer))
	_ = playersGroup.AddEndpoint("setStreamStatus", micro.HandlerFunc(playerStreamStatus))
	_ = playersGroup.AddEndpoint("setTags", micro.HandlerFunc(playerSetTags))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func playerConnect(req micro.Request) {
	var pcon PlayerData
	var err error
	if err = pcon.Deserialize(req); err != nil {
		req.RespondJSON(err)
		return
	}
	if !pcon.isValid(CONNECT) {
		slog.Error(fmt.Sprintf("Required values not provided: %s", helpers.PrettyPrint(pcon)))
		req.RespondJSON(&PlayerError{400, "Missing Required Fields"})
		return
	}

	// insert player if it doesn't exist, else update nickname and zone on connect
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), dbops.CreateUpdatePlayerParams{Login: *pcon.Login, Nickname: sql.NullString{String: *pcon.Nickname, Valid: true}, Zone: sql.NullString{String: *pcon.Zone, Valid: true}, GameType: *pcon.GameType}); err != nil {
		slog.Error("Failed to create or update player", "error", err)
		req.RespondJSON(&PlayerError{500, "Internal Server Error"})
		return
	}
	var fetchedPlayer dbops.TmPlayer
	if fetchedPlayer, err = config.ENV.DB.GetPlayer(context.Background(), dbops.GetPlayerParams{Login: *pcon.Login, GameType: *pcon.GameType}); err != nil {
		slog.Error("Failed to get player", "error", err)
		req.RespondJSON(&PlayerError{500, "Internal Server Error"})
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", helpers.PrettyPrint(pcon), helpers.PrettyPrint(fetchedPlayer)))
	req.RespondJSON(fetchedPlayer)
}

func playerFinish(req micro.Request) {
	var pcon PlayerData
	if err := pcon.Deserialize(req); err != nil {
		req.RespondJSON(err)
	}
	slog.Debug(pcon.String())
	req.RespondJSON(pcon)
}

func playerSetNickname(req micro.Request) {
	var pcon PlayerData
	var err error
	if err = pcon.Deserialize(req); err != nil {
		req.RespondJSON(err)
		return
	}
	if !pcon.isValid(NICKNAME) {
		slog.Error(fmt.Sprintf("Required values not provided: %s", helpers.PrettyPrint(pcon)))
		req.RespondJSON(&PlayerError{400, "Missing Required Fields"})
		return
	}

	// update player nickname
	if err = config.ENV.DB.CreateUpdatePlayer(context.Background(), dbops.CreateUpdatePlayerParams{Login: *pcon.Login, Nickname: sql.NullString{String: *pcon.Nickname, Valid: true}, GameType: *pcon.GameType}); err != nil {
		slog.Error("Failed to create or update player nickname", "error", err)
		req.RespondJSON(&PlayerError{500, "Internal Server Error"})
		return
	}
	var fetchedPlayer dbops.TmPlayer
	if fetchedPlayer, err = config.ENV.DB.GetPlayer(context.Background(), dbops.GetPlayerParams{Login: *pcon.Login, GameType: *pcon.GameType}); err != nil {
		slog.Error("Failed to get player", "error", err)
		req.RespondJSON(&PlayerError{500, "Internal Server Error"})
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse %s", helpers.PrettyPrint(pcon), helpers.PrettyPrint(fetchedPlayer)))
	req.RespondJSON(fetchedPlayer)
}

func playerAddStreamer(req micro.Request) {
	var pcon PlayerData
	if err := json.Unmarshal(req.Data(), &pcon); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return
	}
	slog.Debug(pcon.String())
	req.RespondJSON(pcon)
}

func playerStreamStatus(req micro.Request) {
	var pcon PlayerData
	if err := json.Unmarshal(req.Data(), &pcon); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return
	}
	slog.Debug(pcon.String())
	req.RespondJSON(pcon)
}

func playerSetTags(req micro.Request) {
	var pcon PlayerData
	if err := json.Unmarshal(req.Data(), &pcon); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return
	}
	slog.Debug(pcon.String())
	req.RespondJSON(pcon)
}
