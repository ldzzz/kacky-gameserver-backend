package server

type ServerLeaderboard struct {
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	Edition  *int   `json:"edition"`
}

type ServerMapRecords struct {
	MapUid string `json:"mapUid" validate:"required"`
}

type ServerMapInfo struct {
	MapUid        string `json:"mapUid" validate: required`
	MapName       string `json:"mapName" validate: required`
	MapAuthor     string `json:"mapAuthor" validate: required`
	MapAuthorTime int    `json:"mapAuthorTime" validate: required`
	StartStamp    string `json:"startStamp" validate: required`
}

type ServerSync struct {
	ServerLogin string        `json:"serverLogin" validate: required`
	ServerName  string        `json:"serverName" validate: required`
	GameType    string        `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	MapInfo     ServerMapInfo `json:"mapInfo" validate: required`
	NextMaps    []string      `json:"nextMaps" validate: required`
}
