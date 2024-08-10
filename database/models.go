// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package database

import (
	"database/sql"
	"encoding/json"
	"time"
)

type ApiKey struct {
	ID        int64     `json:"id"`
	Key       string    `json:"key"`
	Name      string    `json:"name"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type Event struct {
	ID        int64     `json:"id"`
	Edition   int32     `json:"edition"`
	GameType  string    `json:"gameType"`
	StartsAt  time.Time `json:"startsAt"`
	EndsAt    time.Time `json:"endsAt"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type EventFinish struct {
	ID             int64     `json:"id"`
	MapUid         string    `json:"mapUid"`
	PlayerID       int64     `json:"playerId"`
	Score          int32     `json:"score"`
	FinishCounter  int32     `json:"finishCounter"`
	CreatedAt      time.Time `json:"createdAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
	LastImprovedAt time.Time `json:"lastImprovedAt"`
}

type EventPlayerEditionStat struct {
	ID        int64     `json:"id"`
	PlayerID  int64     `json:"playerId"`
	Average   float64   `json:"average"`
	Finishes  int32     `json:"finishes"`
	EventID   int64     `json:"eventId"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type Finish struct {
	ID             int64     `json:"id"`
	MapUid         string    `json:"mapUid"`
	PlayerID       int64     `json:"playerId"`
	Score          int32     `json:"score"`
	FinishCounter  int32     `json:"finishCounter"`
	CreatedAt      time.Time `json:"createdAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
	LastImprovedAt time.Time `json:"lastImprovedAt"`
}

type KarmaVote struct {
	ID        int64     `json:"id"`
	MapUid    string    `json:"mapUid"`
	PlayerID  int64     `json:"playerId"`
	Vote      float64   `json:"vote"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type Map struct {
	ID            int64     `json:"id"`
	MapUid        string    `json:"mapUid"`
	EventID       int64     `json:"eventId"`
	FullName      string    `json:"fullName"`
	Number        int32     `json:"number"`
	Author        string    `json:"author"`
	AuthorTime    int32     `json:"authorTime"`
	TotalPlaytime int32     `json:"totalPlaytime"`
	CreatedAt     time.Time `json:"createdAt"`
	UpdatedAt     time.Time `json:"updatedAt"`
}

type PlayerEditionStat struct {
	ID        int64     `json:"id"`
	PlayerID  int64     `json:"playerId"`
	Average   float64   `json:"average"`
	Finishes  int32     `json:"finishes"`
	EventID   int64     `json:"eventId"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type Server struct {
	ID         int64         `json:"id"`
	Name       string        `json:"name"`
	GameType   string        `json:"gameType"`
	Difficulty sql.NullInt32 `json:"difficulty"`
	Timelimit  int32         `json:"timelimit"`
	Online     int8          `json:"online"`
	CreatedAt  time.Time     `json:"createdAt"`
	UpdatedAt  time.Time     `json:"updatedAt"`
}

type TmPlayer struct {
	ID            int64          `json:"id"`
	Login         string         `json:"login"`
	GameType      string         `json:"gameType"`
	Zone          sql.NullString `json:"zone"`
	TotalPlaytime int32          `json:"totalPlaytime"`
	Nickname      sql.NullString `json:"nickname"`
	Role          string         `json:"role"`
	IsMuted       int8           `json:"isMuted"`
	IsBlacklisted int8           `json:"isBlacklisted"`
	CreatedAt     time.Time      `json:"createdAt"`
	UpdatedAt     time.Time      `json:"updatedAt"`
}

type UserMetadatum struct {
	ID           int64           `json:"id"`
	WebUserID    sql.NullInt64   `json:"webUserId"`
	TmnfPlayerID sql.NullInt64   `json:"tmnfPlayerId"`
	Tm20PlayerID sql.NullInt64   `json:"tm20PlayerId"`
	StreamData   json.RawMessage `json:"streamData"`
	Tags         json.RawMessage `json:"tags"`
	Difficulties json.RawMessage `json:"difficulties"`
	Alarms       json.RawMessage `json:"alarms"`
	CreatedAt    time.Time       `json:"createdAt"`
	UpdatedAt    time.Time       `json:"updatedAt"`
}

type WebUser struct {
	ID           int64          `json:"id"`
	DiscordLogin string         `json:"discordLogin"`
	Tm20PlayerID sql.NullInt64  `json:"tm20PlayerId"`
	TmnfPlayerID sql.NullInt64  `json:"tmnfPlayerId"`
	Role         sql.NullString `json:"role"`
	CreatedAt    time.Time      `json:"createdAt"`
	UpdatedAt    time.Time      `json:"updatedAt"`
}

type WorldRecord struct {
	ID        int64     `json:"id"`
	MapUid    string    `json:"mapUid"`
	WrHolder  string    `json:"wrHolder"`
	Score     int32     `json:"score"`
	Source    string    `json:"source"`
	DrivenAt  time.Time `json:"drivenAt"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}
