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
	_ = serverGroup.AddEndpoint("mapRecords", micro.HandlerFunc(serverMapRecords))
	_ = serverGroup.AddEndpoint("sync", micro.HandlerFunc(serverSync))
	_ = serverGroup.AddEndpoint("mapEnd", micro.HandlerFunc(serverMapEnd))

	_ = serverGroup.AddEndpoint("mapStart", micro.HandlerFunc(serverMapStart))
	_ = serverGroup.AddEndpoint("mapSync", micro.HandlerFunc(serverMapSync))
	_ = serverGroup.AddEndpoint("setDifficulty", micro.HandlerFunc(serverSetDifficulty))
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

	// get map records by uid (sorted)
	var mapRecords []*database.GetMapSortedRecordsRow
	if mapRecords, err = config.ENV.DB.GetMapSortedRecords(context.Background(), sd.MapUid); err != nil && err != sql.ErrNoRows {
		slog.Error("Couldn't retrieve map records", "error", err)
		_ = req.RespondJSON(err)
		return
	}

	// return map records
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

	// marshal to json string
	var currentMapInfoData json.RawMessage
	if currentMapInfoData, err = json.Marshal(sd.CurrentMapInfo); err != nil {
		slog.Error("Unable to marshal currentMapInfoData data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	// add more info for next maps to store to db for easier access
	var nextMapsData []apihelpers.ServerNextMapInfo
	for _, mapUid := range sd.NextMaps {
		var currMap *db.Map
		if currMap, err = config.ENV.DB.GetMapByUid(context.Background(), mapUid); err != nil {
			_ = req.RespondJSON(&utils.RequestError{Code: 400, Message: "MapUID doesnt exist"})
			return
		}
		nextMapsData = append(nextMapsData, apihelpers.ServerNextMapInfo{MapUid: currMap.MapUid, MapName: currMap.FullName, MapNumber: currMap.Number, MapAuthor: currMap.Author, MapAuthorTime: currMap.AuthorTime})
	}

	// marshal to json string
	var nextMapsDataSerialized json.RawMessage
	if nextMapsDataSerialized, err = json.Marshal(nextMapsData); err != nil {
		slog.Error("Unable to marshal nextMapsData data", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	// store to db
	if err = config.ENV.DB.CreateUpdateServer(context.Background(), database.CreateUpdateServerParams{Login: sd.ServerLogin, Name: sd.ServerName, GameType: sd.GameType, TimeLimit: sd.TimeLimit, CurrentMapInfo: currentMapInfoData, NextMaps: nextMapsDataSerialized}); err != nil {
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

	// return serverlist
	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(sd), utils.PrettyPrint(serverList)))
	_ = req.RespondJSON(serverList)
}

func serverMapEnd(req micro.Request) {
	var sd apihelpers.ServerMapEndSync
	var err error

	if err = utils.Deserialize(req.Data(), &sd); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// get current servers
	var server *db.GetServerByLoginRow
	if server, err = config.ENV.DB.GetServerByLogin(context.Background(), db.GetServerByLoginParams{Login: sd.ServerLogin, GameType: sd.GameType}); err != nil {
		slog.Error("Unable to get a server by login", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	// check currentmapinfo same and calculate playtime (in minutes)
	var currentMapInfo apihelpers.ServerCurrentMapInfo
	if err = utils.Deserialize(server.CurrentMapInfo, &currentMapInfo); err != nil {
		slog.Error("Unable to deserialize database currentMapInfo", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}

	var playtime *int32
	if playtime, err = apihelpers.CalculateMapPlaytime(currentMapInfo, sd.CurrentMapInfo); err != nil {
		_ = req.RespondJSON(err)
		return
	}

	// update map playtime
	if err = config.ENV.DB.UpdateMapPlaytime(context.Background(), database.UpdateMapPlaytimeParams{TotalPlaytime: *playtime, MapUid: sd.CurrentMapInfo.MapUid}); err != nil {
		slog.Error("Couldn't add/update server", "error", err)
		_ = req.RespondJSON(err)
		return
	}
	// return mapdata with updated total_playtime
	var mapData *db.Map
	if mapData, err = config.ENV.DB.GetMapByUid(context.Background(), sd.CurrentMapInfo.MapUid); err != nil {
		slog.Error("Unable to obtain map info", "error", err)
		_ = req.RespondJSON(&utils.RequestError{Code: 500, Message: "Internal Server Error"})
		return
	}
	slog.Debug(fmt.Sprintf("Request: %s\nResponse: %s", utils.PrettyPrint(sd), utils.PrettyPrint(mapData)))
	_ = req.RespondJSON(mapData)
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
