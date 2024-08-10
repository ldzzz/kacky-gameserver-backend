package main

import (
	"database/sql"
	"fmt"
	"log/slog"
	"os"
	"os/signal"
	"time"

	"github.com/go-sql-driver/mysql"
	"github.com/ldzzz/kacky-gameserver-backend/api/players"
	"github.com/ldzzz/kacky-gameserver-backend/config"
	dbops "github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/nats-io/nats.go"
)

func main() {
	// load config environment variables
	var cfg *config.Config
	var err error
	if cfg, err = config.GetConfig(); err != nil {
		fmt.Printf("Couldn't read configuration environment variables: %s\n", err)
		os.Exit(1)
	}

	// initialize Logging
	config.InitLogging(cfg.Debug)
	slog.Info("Initialized configuration & logging")
	slog.Debug("Environment variables loaded:", "Config", cfg.String())

	if err := Run(cfg); err != nil {
		slog.Error("Something went wrong", "error", err)
		os.Exit(1)
	}
	slog.Info("Exiting..")

}

func Run(cfg *config.Config) error {
	var err error

	/*************************************NATS*************************************/
	slog.Info("Initializing NATS connection")
	var nc *nats.Conn
	opts := nats.Options{
		Url:            cfg.NATSHost,
		Name:           "gsb",
		AllowReconnect: true,
		MaxReconnect:   -1,
		Token:          cfg.NATSToken,
	}

	if nc, err = opts.Connect(); err != nil {
		return err
	}
	defer nc.Drain()
	slog.Info(fmt.Sprintf("Connected to NATS server: %s:%d", cfg.NATSHost, cfg.NATSPort))

	/***********************************database***********************************/
	slog.Info("Initializing database connection")
	var db *sql.DB
	dbcfg := mysql.Config{
		User:                 cfg.DBUser,
		Passwd:               cfg.DBPass,
		Net:                  "tcp",
		Addr:                 fmt.Sprintf("%s:%d", cfg.DBHost, cfg.DBPort),
		DBName:               cfg.DBName,
		CheckConnLiveness:    true,
		AllowNativePasswords: true,
		ParseTime:            true,
		Loc:                  time.UTC,
	}

	// Get a database handle.
	fmt.Printf("%s", dbcfg.FormatDSN())
	if db, err = sql.Open("mysql", dbcfg.FormatDSN()); err != nil {
		return err
	}

	// configure connection pool
	db.SetMaxOpenConns(32)
	db.SetMaxIdleConns(32)
	db.SetConnMaxLifetime(30 * time.Minute)

	// ping database
	if err := db.Ping(); err != nil {
		return err
	}

	defer db.Close()
	queryConn := dbops.New(db)
	slog.Info(fmt.Sprintf("Connected to the database: %s@%s:%d", cfg.DBUser, cfg.DBHost, cfg.DBPort))
	// Create an instance of Env containing the connection pool.
	config.ENV = &config.Env{CFG: cfg, DB: queryConn, NATS: nc}

	// init endpoints
	slog.Info("Initializing endpoints..")
	players.InitServices()

	//rep, _ := nc.Request("player.connect", []byte("{\"login\":\"mylogin\",\"nickname\":\"mylogin\",\"zone\":\"A|B|C\", \"gameType\": \"KK\"}"), time.Second)
	//fmt.Println(string(rep.Data))

	// TODO: no clue how to wait properly (this is Ctrl+C wait)
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	<-c
	return nil
}

// TODO: define error handling ??
// TODO: write unit tests
// TODO: write integration tests
// TODO: pprof
//TODO: in backend when user relates to the accounts, need to consider metadata merging
//		i.e. stream added for two players kk and kr, user makes a web account, links kk and kr accounts, metadata must be merged at this point,
//		i.e. we have to search for metadata of both accounts, delete both metadatas, create a new aggregate metadata
