package admin

import (
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/nats-io/nats.go/micro"
)

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "AdminService",
		Version: "1.0.0",
	})
	//adminGroup := srv.AddGroup("admin")
	//_ = adminGroup.AddEndpoint("addStreamer", micro.HandlerFunc(adminAddStreamer))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}
