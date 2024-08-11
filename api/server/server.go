package server

import (
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/nats-io/nats.go/micro"
)

type ServerData struct {
	Difficulty *string `json:"difficulty"`
}

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "ServersService",
		Version: "1.0.0",
	})
	playersGroup := srv.AddGroup("server")
	_ = playersGroup.AddEndpoint("mapStart", micro.HandlerFunc(serverMapStart))
	_ = playersGroup.AddEndpoint("mapEnd", micro.HandlerFunc(serverMapEnd))
	_ = playersGroup.AddEndpoint("setDifficulty", micro.HandlerFunc(serverSetDifficulty))
	_ = playersGroup.AddEndpoint("sync", micro.HandlerFunc(serverSync))
	_ = playersGroup.AddEndpoint("mapSync", micro.HandlerFunc(serverMapSync))
	_ = playersGroup.AddEndpoint("leaderboard", micro.HandlerFunc(serverLeaderboard))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func serverSetDifficulty(req micro.Request) {
	req.Respond(req.Data())
}

func serverSync(req micro.Request) {
	req.Respond(req.Data())
}

func serverMapSync(req micro.Request) {
	req.Respond(req.Data())
}

func serverLeaderboard(req micro.Request) {
	req.Respond(req.Data())
}

func serverMapStart(req micro.Request) {
	req.Respond(req.Data())
}

func serverMapEnd(req micro.Request) {
	req.Respond(req.Data())
}
