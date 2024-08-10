-- +goose Up
-- +goose StatementBegin

/*
# tm_players mock
*/
/*real players*/
INSERT INTO tm_players (id, login, game_type, nickname, role) VALUES (1, "el-djinn", "KK", "el-djinn", "admin");
INSERT INTO tm_players (id, login, game_type, nickname, role) VALUES (2, "3zrJPQyLTZKF2Mrkr-qUEw", "KR", "el-djinn", "admin");
/*fake players*/
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (10, "*fakeplayer1*", "KK", "player1");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (11, "*fakeplayer2*", "KK", "player2");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (12, "*fakeplayer3*", "KK", "player3");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (13, "*fakeplayer4*", "KK", "player4");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (14, "*fakeplayer5*", "KK", "player5");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (15, "*fakeplayer6*", "KR", "player6");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (16, "*fakeplayer7*", "KR", "player7");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (17, "*fakeplayer8*", "KR", "player8");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (18, "*fakeplayer9*", "KR", "player9");
INSERT INTO tm_players (id, login, game_type, nickname) VALUES (19, "*fakeplayer10*", "KR", "player10");

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
DELETE FROM web_users;
ALTER TABLE web_users AUTO_INCREMENT = 1;
DELETE FROM tm_players;
ALTER TABLE tm_players AUTO_INCREMENT = 1;
-- +goose StatementEnd
