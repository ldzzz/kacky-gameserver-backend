-- +goose Up
-- +goose StatementBegin

/*
# tm_players mock
*/
/*real players*/
INSERT INTO tm_players (id, login, game_type, zone, nickname, role) VALUES (1, "3zrJPQyLTZKF2Mrkr-qUEw", "KR", "World|Europe|Bosnia and Herzegovina", "el-djinn", "admin");
INSERT INTO tm_players (id, login, game_type, zone, nickname, role) VALUES (2, "el-djinn", "KK", "World|Europe|Bosnia and Herzegovina", "el-djinn", "admin");
INSERT INTO tm_players (id, login, game_type, zone, nickname, role) VALUES (3, "EdbzfLXMS_aI_PjZCVaygQ", "KR", "World|Europe|Finland", "reaby", "admin");
INSERT INTO tm_players (id, login, game_type, zone, nickname, role) VALUES (4, "reaby", "KK", "World|Europe|Finland", "reaby", "admin");
/*fake players*/
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (10, "*fakeplayer1*", "KK", "World|Europe|Testland", "player1");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (11, "*fakeplayer2*", "KK", "World|Europe|Testland", "player2");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (12, "*fakeplayer3*", "KK", "World|Europe|Testland", "player3");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (13, "*fakeplayer4*", "KK", "World|Europe|Testland", "player4");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (14, "*fakeplayer5*", "KK", "World|Europe|Testland", "player5");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (15, "*fakeplayer6*", "KR", "World|Europe|Testland", "player6");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (16, "*fakeplayer7*", "KR", "World|Europe|Testland", "player7");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (17, "*fakeplayer8*", "KR", "World|Europe|Testland", "player8");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (18, "*fakeplayer9*", "KR", "World|Europe|Testland", "player9");
INSERT INTO tm_players (id, login, game_type, zone, nickname) VALUES (19, "*fakeplayer10*", "KR", "World|Europe|Testland",  "player10");

/*
# web_users mock
*/
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (1, "djinner", 1, 2, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (2, ".garlik", null, null, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (3, "valascus", null, null, "admin");
INSERT INTO web_users (id, discord_login, tm20_player_id, tmnf_player_id, role) VALUES (4, "reaby", 3, 4, "admin");

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM web_users;
ALTER TABLE web_users AUTO_INCREMENT = 1;
DELETE FROM tm_players;
ALTER TABLE tm_players AUTO_INCREMENT = 1;
-- +goose StatementEnd
