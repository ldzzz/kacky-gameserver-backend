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

-- name: GetPlayerMetadata :one
SELECT * FROM user_metadata
WHERE tm20_player_id = ? OR tmnf_player_id = ?;

-- name: GetPlayerFinishes :many
SELECT finishes.* FROM finishes
JOIN tm_players ON finishes.player_id = tm_players.id
WHERE tm_players.login = ? AND tm_players.game_type = ?;


-- name: CreateUpdateStreamDataTM20 :exec
INSERT INTO user_metadata (
  tm20_player_id, stream_data
) VALUES (
  ?,?
)
ON DUPLICATE KEY UPDATE stream_data=VALUES(stream_data);

-- name: CreateUpdateStreamDataTMNF :exec
INSERT INTO user_metadata (
  tmnf_player_id, stream_data
) VALUES (
  ?,?
)
ON DUPLICATE KEY UPDATE stream_data=VALUES(stream_data);

-- name: SetPlayerRole :exec
UPDATE tm_players SET role = ? WHERE login = ? AND game_type = ?;