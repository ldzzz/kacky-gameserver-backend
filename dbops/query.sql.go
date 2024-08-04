// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: query.sql

package dbops

import (
	"context"
	"database/sql"
	"encoding/json"
)

const createUpdatePlayer = `-- name: CreateUpdatePlayer :exec
INSERT INTO tm_players (
  login, nickname, zone, game_type
) VALUES (
  ?,?,?,?
)
ON DUPLICATE KEY UPDATE nickname=VALUES(nickname), zone=VALUES(zone)
`

type CreateUpdatePlayerParams struct {
	Login    string         `json:"login"`
	Nickname sql.NullString `json:"nickname"`
	Zone     sql.NullString `json:"zone"`
	GameType string         `json:"gameType"`
}

func (q *Queries) CreateUpdatePlayer(ctx context.Context, arg CreateUpdatePlayerParams) error {
	_, err := q.exec(ctx, q.createUpdatePlayerStmt, createUpdatePlayer,
		arg.Login,
		arg.Nickname,
		arg.Zone,
		arg.GameType,
	)
	return err
}

const createUpdateStreamDataTM20 = `-- name: CreateUpdateStreamDataTM20 :exec
INSERT INTO user_metadata (
  tm20_player_id, stream_data
) VALUES (
  ?,?
)
ON DUPLICATE KEY UPDATE stream_data=VALUES(stream_data)
`

type CreateUpdateStreamDataTM20Params struct {
	Tm20PlayerID sql.NullInt64   `json:"tm20PlayerId"`
	StreamData   json.RawMessage `json:"streamData"`
}

func (q *Queries) CreateUpdateStreamDataTM20(ctx context.Context, arg CreateUpdateStreamDataTM20Params) error {
	_, err := q.exec(ctx, q.createUpdateStreamDataTM20Stmt, createUpdateStreamDataTM20, arg.Tm20PlayerID, arg.StreamData)
	return err
}

const createUpdateStreamDataTMNF = `-- name: CreateUpdateStreamDataTMNF :exec
INSERT INTO user_metadata (
  tmnf_player_id, stream_data
) VALUES (
  ?,?
)
ON DUPLICATE KEY UPDATE stream_data=VALUES(stream_data)
`

type CreateUpdateStreamDataTMNFParams struct {
	TmnfPlayerID sql.NullInt64   `json:"tmnfPlayerId"`
	StreamData   json.RawMessage `json:"streamData"`
}

func (q *Queries) CreateUpdateStreamDataTMNF(ctx context.Context, arg CreateUpdateStreamDataTMNFParams) error {
	_, err := q.exec(ctx, q.createUpdateStreamDataTMNFStmt, createUpdateStreamDataTMNF, arg.TmnfPlayerID, arg.StreamData)
	return err
}

const getPlayer = `-- name: GetPlayer :one
SELECT id, login, game_type, zone, total_finishes, nickname, role, is_muted, is_blacklisted, created_at, updated_at FROM tm_players
WHERE login = ? AND game_type = ?
`

type GetPlayerParams struct {
	Login    string `json:"login"`
	GameType string `json:"gameType"`
}

func (q *Queries) GetPlayer(ctx context.Context, arg GetPlayerParams) (TmPlayer, error) {
	row := q.queryRow(ctx, q.getPlayerStmt, getPlayer, arg.Login, arg.GameType)
	var i TmPlayer
	err := row.Scan(
		&i.ID,
		&i.Login,
		&i.GameType,
		&i.Zone,
		&i.TotalFinishes,
		&i.Nickname,
		&i.Role,
		&i.IsMuted,
		&i.IsBlacklisted,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const getPlayerFinishes = `-- name: GetPlayerFinishes :many
SELECT finishes.id, finishes.map_id, finishes.player_id, finishes.score, finishes.finish_counter, finishes.created_at, finishes.updated_at, finishes.last_finished_at FROM finishes
JOIN tm_players ON finishes.player_id = tm_players.id
WHERE tm_players.login = ? AND tm_players.game_type = ?
`

type GetPlayerFinishesParams struct {
	Login    string `json:"login"`
	GameType string `json:"gameType"`
}

func (q *Queries) GetPlayerFinishes(ctx context.Context, arg GetPlayerFinishesParams) ([]Finish, error) {
	rows, err := q.query(ctx, q.getPlayerFinishesStmt, getPlayerFinishes, arg.Login, arg.GameType)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Finish
	for rows.Next() {
		var i Finish
		if err := rows.Scan(
			&i.ID,
			&i.MapID,
			&i.PlayerID,
			&i.Score,
			&i.FinishCounter,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.LastFinishedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getPlayerMetadata = `-- name: GetPlayerMetadata :one
SELECT id, web_user_id, tmnf_player_id, tm20_player_id, stream_data, tags, difficulties, alarms, created_at, updated_at FROM user_metadata
WHERE tm20_player_id = ? OR tmnf_player_id = ?
`

type GetPlayerMetadataParams struct {
	Tm20PlayerID sql.NullInt64 `json:"tm20PlayerId"`
	TmnfPlayerID sql.NullInt64 `json:"tmnfPlayerId"`
}

func (q *Queries) GetPlayerMetadata(ctx context.Context, arg GetPlayerMetadataParams) (UserMetadatum, error) {
	row := q.queryRow(ctx, q.getPlayerMetadataStmt, getPlayerMetadata, arg.Tm20PlayerID, arg.TmnfPlayerID)
	var i UserMetadatum
	err := row.Scan(
		&i.ID,
		&i.WebUserID,
		&i.TmnfPlayerID,
		&i.Tm20PlayerID,
		&i.StreamData,
		&i.Tags,
		&i.Difficulties,
		&i.Alarms,
		&i.CreatedAt,
		&i.UpdatedAt,
	)
	return i, err
}

const setPlayerRole = `-- name: SetPlayerRole :exec
UPDATE tm_players SET role = ? WHERE login = ? AND game_type = ?
`

type SetPlayerRoleParams struct {
	Role     string `json:"role"`
	Login    string `json:"login"`
	GameType string `json:"gameType"`
}

func (q *Queries) SetPlayerRole(ctx context.Context, arg SetPlayerRoleParams) error {
	_, err := q.exec(ctx, q.setPlayerRoleStmt, setPlayerRole, arg.Role, arg.Login, arg.GameType)
	return err
}
