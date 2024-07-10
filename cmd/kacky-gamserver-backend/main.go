package main

import (
	"fmt"
	"log/slog"
	"os"

	"github.com/ldzzz/kacky-gameserver-backend/config"
)

func main() {
	// load config environment variables
	var cfg *config.Config
	var err error
	if cfg, err = config.ReadConfig(); err != nil {
		fmt.Printf("Couldn't read configuration environment variables: %s\n", err)
		os.Exit(1)
	}

	// initialize Logging
	config.InitLogging(cfg.Debug)
	slog.Info("Initialized configuration & logging")
	//slog.Debug("Environment variables loaded:", cfg)

	// TODO: open connection to db
	// TODO: open connection to NATS
	// TODO: setup callbacks for all NATS channels
	// TODO: define error handling ??
	// TODO: write unit tests
	// TODO: write integration tests
}
