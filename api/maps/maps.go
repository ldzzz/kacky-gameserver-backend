package maps

import (
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/nats-io/nats.go/micro"
)

type MapData struct {
	MapUID *string `json:"mapUid"`
}

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "MapsService",
		Version: "1.0.0",
	})
	playersGroup := srv.AddGroup("map")
	_ = playersGroup.AddEndpoint("mapstart", micro.HandlerFunc(mapStart))
	_ = playersGroup.AddEndpoint("mapend", micro.HandlerFunc(mapEnd))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func mapStart(req micro.Request) {
	req.Respond(req.Data())
}

func mapEnd(req micro.Request) {
	req.Respond(req.Data())
}
