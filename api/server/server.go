package server

import (
	"context"
	"database/sql"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/ldzzz/kacky-gameserver-backend/internal/apihelpers"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
	"github.com/nats-io/nats.go/micro"
)

type ServerData struct {
	Difficulty *string `json:"difficulty"`
}

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "ServerService",
		Version: "1.0.0",
	})
	playersGroup := srv.AddGroup("server")
	_ = playersGroup.AddEndpoint("mapStart", micro.HandlerFunc(serverMapStart))
	_ = playersGroup.AddEndpoint("mapEnd", micro.HandlerFunc(serverMapEnd))
	_ = playersGroup.AddEndpoint("mapRecords", micro.HandlerFunc(serverMapRecords))
	_ = playersGroup.AddEndpoint("mapSync", micro.HandlerFunc(serverMapSync))
	_ = playersGroup.AddEndpoint("setDifficulty", micro.HandlerFunc(serverSetDifficulty))
	_ = playersGroup.AddEndpoint("sync", micro.HandlerFunc(serverSync))
	_ = playersGroup.AddEndpoint("leaderboard", micro.HandlerFunc(serverLeaderboard))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func serverLeaderboard(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}

func serverMapRecords(req micro.Request) {
	var sd apihelpers.ServerMapRecords
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	var mapRecords []database.GetMapSortedRecordsRow
	if mapRecords, err = config.ENV.DB.GetMapSortedRecords(context.Background(), sd.MapUid); err != nil && err != sql.ErrNoRows {
		slog.Error("Couldn't retrieve map records", "error", err)
		_ = req.RespondJSON(err)
		return
	}

	slog.Info(fmt.Sprintf("Returning map records for: %s", sd.MapUid))
	slog.Debug(utils.PrettyPrint(mapRecords))
	_ = req.RespondJSON(mapRecords)
}

func serverSetDifficulty(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}

func serverSync(req micro.Request) {
	var sd apihelpers.ServerSync
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

}

func serverMapSync(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}

func serverMapStart(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}

func serverMapEnd(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}
