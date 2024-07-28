package players

import (
	"encoding/json"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/nats-io/nats.go/micro"
)

type PlayerData struct {
	Login       *string `json:"login"`
	Nickname    *string `json:"nickname"`
	Zone        *string `json:"zone"`
	MapUID      *string `json:"mapuid"`
	Score       *int    `json:"score"`
	Status      *bool   `json:"status"`
	Platform    *string `json:"platform"`
	StreamLogin *string `json:"streamlogin"`
}

func (pc *PlayerData) String() string {
	s, _ := json.Marshal(pc)
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
	_ = playersGroup.AddEndpoint("sync", micro.HandlerFunc(playerConnect))
	_ = playersGroup.AddEndpoint("nickname", micro.HandlerFunc(playerSetNickname))
	_ = playersGroup.AddEndpoint("streamer", micro.HandlerFunc(playerAddStreamer))
	_ = playersGroup.AddEndpoint("streamstatus", micro.HandlerFunc(playerStreamStatus))
	_ = playersGroup.AddEndpoint("tag", micro.HandlerFunc(playerTag))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func playerConnect(req micro.Request) {
	var pcon PlayerData
	if err := json.Unmarshal(req.Data(), &pcon); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return
	}
	slog.Debug(pcon.String())
	req.RespondJSON(pcon)
}

func playerFinish(req micro.Request) {
	req.Respond(req.Data())
}

func playerSetNickname(req micro.Request) {
	req.Respond(req.Data())
}

func playerAddStreamer(req micro.Request) {
	req.Respond(req.Data())
}

func playerStreamStatus(req micro.Request) {
	req.Respond(req.Data())
}

func playerTag(req micro.Request) {
	req.Respond(req.Data())
}
