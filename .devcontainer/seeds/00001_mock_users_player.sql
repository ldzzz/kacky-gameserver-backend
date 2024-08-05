-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';

/*
# tm_players mock
*/
/*real players*/
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname, role) VALUES (1, "el-djinn", "KK", 7, "el-djinn", "admin");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname, role) VALUES (2, "3zrJPQyLTZKF2Mrkr-qUEw", "KR", 32, "el-djinn", "admin");
/*fake players*/
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (10, "*fakeplayer1*", "KK", 0, "player1");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (11, "*fakeplayer2*", "KK", 12, "player2");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (12, "*fakeplayer3*", "KK", 15, "player3");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (13, "*fakeplayer4*", "KK", 227, "player4");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (14, "*fakeplayer5*", "KK", 25, "player5");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (15, "*fakeplayer6*", "KR", 100, "player6");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (16, "*fakeplayer7*", "KR", 22, "player7");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (17, "*fakeplayer8*", "KR", 56, "player8");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (18, "*fakeplayer9*", "KR", 74, "player9");
INSERT INTO tm_players (id, login, game_type, total_finishes, nickname) VALUES (19, "*fakeplayer10*", "KR", 22, "player10");

/*
# web_users mock
*/
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (1, "djinner", 1, 2, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (2, ".garlik", null, null, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (3, "valascus", null, null, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (4, "reaby", null, null, "admin");


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';

TRUNCATE tm_players;
TRUNCATE web_users;

-- +goose StatementEnd
