package server

type ServerLeaderboard struct {
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania Maniaplanet"`
	Edition  *int   `json:"edition"`
}

type ServerMapRecords struct {
	MapUid string `json:"mapUid" validate:"required"`
}
