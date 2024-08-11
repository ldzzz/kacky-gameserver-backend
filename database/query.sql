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
SELECT finishes.map_uid, maps.number, finishes.score, finishes.finish_counter, finishes.created_at, finishes.last_improved_at FROM finishes
JOIN maps ON finishes.map_uid = maps.map_uid
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

-- name: FetchMapByUid :one
SELECT * FROM maps WHERE map_uid = ?;

-- name: FetchPlayerMapFinish :one
SELECT * FROM finishes WHERE map_uid = ? AND player_id = ?;

-- name: CreateUpdatePlayerMapFinish :exec
INSERT INTO finishes (
  map_uid, player_id, score, last_improved_at
) VALUES (
  ?,?,?,?
)
ON DUPLICATE KEY UPDATE finish_counter=finish_counter+1,last_improved_at=if(score > VALUES(score), VALUES(last_improved_at), last_improved_at),score=LEAST(score, VALUES(score));

-- name: GetMapSortedRecords :many
SELECT tm_players.login, tm_players.nickname, finishes.score, finishes.finish_counter, finishes.last_improved_at FROM finishes
JOIN tm_players ON tm_players.id = finishes.player_id
WHERE finishes.map_uid = ?
ORDER BY finishes.score ASC, finishes.last_improved_at ASC;