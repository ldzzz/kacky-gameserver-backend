-- name: GetPlayer :one
SELECT * FROM tm_players
WHERE login = ? AND game_type = ?;

-- name: CreateUpdatePlayer :exec
INSERT INTO tm_players (
  login, nickname, zone, game_type
) VALUES (
  ?,?,?,?
)
ON DUPLICATE KEY UPDATE nickname=VALUES(nickname), zone=VALUES(zone);

-- name: GetPlayerFinishes :many
SELECT finishes.* FROM finishes
JOIN tm_players ON finishes.player_id = tm_players.id
WHERE tm_players.login = ? AND tm_players.game_type = ?;