-- name: GetPlayer :one
SELECT * FROM tm_players
WHERE login = $1;

-- name: CreatePlayer :exec
INSERT INTO tm_players (
  login, nickname, zone, game_type
) VALUES (
  $1, $2, $3, $4
);

-- name: GetPlayerFinishes :many
SELECT finishes.* FROM finishes
JOIN tm_players ON finishes.player_id = tm_players.id
WHERE tm_players.login = $1 AND tm_players.game_type = $2;