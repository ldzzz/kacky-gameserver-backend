package apihelpers

import "time"

type PlayerConnect struct {
	Login    string `json:"login" validate:"required"`
	Nickname string `json:"nickname" validate:"required"`
	Zone     string `json:"zone" validate:"required,contains=0x7C"`
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
}

type PlayerNickname struct {
	Login    string `json:"login" validate:"required"`
	Nickname string `json:"nickname" validate:"required"`
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
}

type PlayerStreamerStatus struct {
	Login        string `json:"login" validate:"required"`
	StreamStatus *bool  `json:"streamStatus" validate:"required"`
	GameType     string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
}

type PlayerFinish struct {
	Login     string    `json:"login" validate:"required"`
	GameType  string    `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	MapUid    string    `json:"mapUid" validate:"required"`
	Score     int32     `json:"score" validate:"required,gt=0"`
	Timestamp time.Time `json:"timestamp" validate:"required"`
}

type PlayerStreamData struct {
	Platform      *string `json:"platform"`
	StreamerLogin *string `json:"streamerLogin"`
	StreamStatus  *bool   `json:"streamStatus"`
}

type PlayerStreamerData struct {
	Login         string `json:"login" validate:"required"`
	Platform      string `json:"platform" validate:"required"`
	StreamerLogin string `json:"streamerLogin" validate:"required"`
	StreamStatus  *bool  `json:"streamStatus" validate:"required"`
	GameType      string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
}

type ServerLeaderboard struct {
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	Edition  *int   `json:"edition"`
}

type ServerMapRecords struct {
	MapUid string `json:"mapUid" validate:"required"`
}

type ServerMapInfo struct {
	MapUid        string `json:"mapUid" validate:"required"`
	MapName       string `json:"mapName" validate:"required"`
	MapAuthor     string `json:"mapAuthor" validate:"required"`
	MapAuthorTime int    `json:"mapAuthorTime" validate:"required"`
	StartStamp    string `json:"startStamp" validate:"required"`
}

type ServerSync struct {
	ServerLogin string        `json:"serverLogin" validate:"required"`
	ServerName  string        `json:"serverName" validate:"required"`
	GameType    string        `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	MapInfo     ServerMapInfo `json:"mapInfo" validate:"required"`
	NextMaps    []string      `json:"nextMaps" validate:"required"`
}
