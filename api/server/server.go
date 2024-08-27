package server

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/ldzzz/kacky-gameserver-backend/database"
	db "github.com/ldzzz/kacky-gameserver-backend/database"
	"github.com/ldzzz/kacky-gameserver-backend/internal/apihelpers"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
	"github.com/nats-io/nats.go/micro"
)

func InitServices() {
	srv, _ := micro.AddService(config.ENV.NATS, micro.Config{
		Name:    "ServerService",
		Version: "1.0.0",
	})
	serverGroup := srv.AddGroup("server")
	_ = serverGroup.AddEndpoint("mapStart", micro.HandlerFunc(serverMapStart))
	_ = serverGroup.AddEndpoint("mapEnd", micro.HandlerFunc(serverMapEnd))
	_ = serverGroup.AddEndpoint("mapRecords", micro.HandlerFunc(serverMapRecords))
	_ = serverGroup.AddEndpoint("mapSync", micro.HandlerFunc(serverMapSync))
	_ = serverGroup.AddEndpoint("setDifficulty", micro.HandlerFunc(serverSetDifficulty))
	_ = serverGroup.AddEndpoint("sync", micro.HandlerFunc(serverSync))
	_ = serverGroup.AddEndpoint("leaderboard", micro.HandlerFunc(serverLeaderboard))

	slog.Info(fmt.Sprintf("Initialized %s", srv.Info()))
}

func serverMapRecords(req micro.Request) {
	var sd apihelpers.ServerMapRecords
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	var mapRecords []*database.GetMapSortedRecordsRow
	if mapRecords, err = config.ENV.DB.GetMapSortedRecords(context.Background(), sd.MapUid); err != nil && err != sql.ErrNoRows {
		slog.Error("Couldn't retrieve map records", "error", err)
		_ = req.RespondJSON(err)
		return
	}

	slog.Info(fmt.Sprintf("Returning map records for: %s", sd.MapUid))
	slog.Debug(utils.PrettyPrint(mapRecords))
	_ = req.RespondJSON(mapRecords)
}

func serverSync(req micro.Request) {
	var sd apihelpers.ServerSync
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	var currentMapInfoData json.RawMessage
	if currentMapInfoData, err = json.Marshal(sd.CurrentMapInfo); err != nil {
		slog.Error("Unable to marshal currentMapInfoData data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var nextMapsData json.RawMessage
	if nextMapsData, err = json.Marshal(sd.NextMaps); err != nil {
		slog.Error("Unable to marshal nextMapsData data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	if err = config.ENV.DB.CreateUpdateServer(context.Background(), database.CreateUpdateServerParams{Login: sd.ServerLogin, Name: sd.ServerName, GameType: sd.GameType, TimeLimit: sd.TimeLimit, CurrentMapInfo: currentMapInfoData, NextMaps: nextMapsData}); err != nil {
		slog.Error("Couldn't add/update server", "error", err)
		_ = req.RespondJSON(err)
		return
	}

	// get serverlist to return
	var serverList []*db.GetServersRow
	if serverList, err = config.ENV.DB.GetServers(context.Background(), sd.GameType); err != nil {
		slog.Error("Unable to get server list", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(sd), utils.PrettyPrint(serverList)))
	_ = req.RespondJSON(serverList)
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

func serverLeaderboard(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}

func serverSetDifficulty(req micro.Request) {
	var sd apihelpers.ServerLeaderboard
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}
}
