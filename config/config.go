package config

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log/slog"
	"os"

	prettylog "github.com/ldzzz/kacky-gameserver-backend/utils/logging"
	"github.com/nats-io/nats.go"
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

func GetConfig() (*Config, error) {
	// load environment mapping
	cfg := &Config{}
	ctx := context.Background()

	if err := envconfig.Process(ctx, cfg); err != nil {
		fmt.Println("here")
		return nil, err
	}

	return cfg, nil
}

func (pc *Config) String() string {
	s, _ := json.Marshal(pc)
	return fmt.Sprintln(string(s))
}

type Config struct {
	NATSHost  string `env:"NATS_ADDR, required"`
	NATSPort  int    `env:"NATS_PORT, required"`
	NATSToken string `env:"NATS_TOKEN, required"`
	DBHost    string `env:"DB_ADDR, required"`
	DBPort    int    `env:"DB_PORT, required"`
	DBUser    string `env:"MYSQL_USER, required"`
	DBPass    string `env:"MYSQL_PASSWORD, required"`
	DBName    string `env:"MYSQL_DATABASE, required"`
	Debug     bool   `env:"DEBUG, default=false"`
}

type Env struct {
	CFG  *Config
	DB   *sql.DB
	NATS *nats.Conn
}

var ENV *Env
