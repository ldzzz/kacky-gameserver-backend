package config

import (
	"context"
	"fmt"
	"log/slog"
	"os"

	prettylog "github.com/ldzzz/kacky-gameserver-backend/utils/logging"
	envconfig "github.com/sethvargo/go-envconfig"
)

func InitLogging(debug bool) {
	// create customised logging functionality
	// if debug then we turn on colored logs for development
	var logger *slog.Logger
	if debug {
		prettyHandler := prettylog.NewHandler(&slog.HandlerOptions{
			Level:       slog.LevelDebug,
			AddSource:   true,
			ReplaceAttr: nil,
		})
		logger = slog.New(prettyHandler)
	} else {
		opts := &slog.HandlerOptions{Level: slog.LevelInfo, AddSource: true}
		handler := slog.NewJSONHandler(os.Stdout, opts)
		logger = slog.New(handler)
	}

	// set customised logger as default one for slog
	slog.SetDefault(logger)
}

func ReadConfig() (*Config, error) {
	// load environment mapping
	cfg := &Config{}
	ctx := context.Background()

	if err := envconfig.Process(ctx, cfg); err != nil {
		fmt.Println("here")
		return nil, err
	}

	return cfg, nil
}

type Config struct {
	NATSHost  string `env:"NATS_ADDR, required"`
	NATSToken string `env:"NATS_TOKEN, required"`
	DBHost    string `env:"DB_ADDR, required"`
	DBPort    int    `env:"DB_PORT, required"`
	DBUser    string `env:"MYSQL_USER, required"`
	DBUPass   string `env:"MYSQL_PASSWORD, required"`
	Debug     bool   `env:"DEBUG, default=false"`
}
