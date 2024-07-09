DROP DATABASE `devDB`;
CREATE DATABASE IF NOT EXISTS `devDB`;
USE `devDB`;

CREATE TABLE `web_users` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `discord_login` VARCHAR(255) UNIQUE NOT NULL,
  `tm20_player_id` BIGINT,
  `tmnf_player_id` BIGINT,
  `role` VARCHAR(255) DEFAULT 'user',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `user_metadata` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNIQUE NOT NULL,
  `stream_data` JSON,
  `tags` JSON,
  `difficulties` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `tm_players` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(255) NOT NULL,
  `account_id` VARCHAR(255) DEFAULT null,
  `game_type` VARCHAR(255),
  `zone` VARCHAR(255) DEFAULT null,
  `total_finishes` INT NOT NULL DEFAULT 0,
  `nickname` VARCHAR(255),
  `role` VARCHAR(255) DEFAULT 'user',
  `is_muted` TINYINT DEFAULT 0,
  `is_blacklisted` TINYINT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `maps` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `event_id` BIGINT NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `number` INT NOT NULL,
  `author` VARCHAR(255) NOT NULL,
  `author_time` INT NOT NULL,
  `total_finishes` INT NOT NULL DEFAULT 0,
  `total_playtime` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `karma_votes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_id` BIGINT NOT NULL,
  `player_id` BIGINT NOT NULL,
  `vote` DOUBLE NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `world_records` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_id` BIGINT UNIQUE NOT NULL,
  `wr_holder` VARCHAR(255) NOT NULL,
  `score` INT NOT NULL,
  `source` VARCHAR(255) NOT NULL,
  `driven_at` TIMESTAMP NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `finishes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_id` BIGINT NOT NULL,
  `player_id` BIGINT NOT NULL,
  `score` INT NOT NULL,
  `finish_counter` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `event_finishes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_id` BIGINT NOT NULL,
  `player_id` BIGINT NOT NULL,
  `score` INT NOT NULL,
  `finish_counter` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `events` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `edition` int NOT NULL,
  `game_type` VARCHAR(255) NOT NULL,
  `starts_at` TIMESTAMP DEFAULT NULL,
  `ends_at` TIMESTAMP DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `player_edition_stats` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `player_id` BIGINT NOT NULL,
  `average` DOUBLE NOT NULL DEFAULT 0,
  `finishes` INT NOT NULL DEFAULT 0,
  `event_id` BIGINT NOT NULL
);

CREATE TABLE `api_keys` (
  `id` bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `servers` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `game_type` VARCHAR(255) NOT NULL,
  `difficulty` INT DEFAULT 0,
  `timelimit` INT NOT NULL DEFAULT 10,
  `online` TINYINT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

/*
# Unique constraints definitions
# in format UQ_<table>_<col1>_<col2>
*/
CREATE UNIQUE INDEX `UQ_tm_players_login_gametype` ON `tm_players` (`login`, `game_type`);
CREATE UNIQUE INDEX `UQ_maps_index_uuid_eventid` ON `maps` (`uuid`, `event_id`);
CREATE UNIQUE INDEX `UQ_karma_votes_mapid_playerid` ON `karma_votes` (`map_id`, `player_id`);
CREATE UNIQUE INDEX `UQ_inishes_mapid_playerid` ON `finishes` (`map_id`, `player_id`);
CREATE UNIQUE INDEX `UQ_event_finishes_mapid_playerid` ON `event_finishes` (`map_id`, `player_id`);
CREATE UNIQUE INDEX `UQ_events_edition_gametype` ON `events` (`edition`, `game_type`);
CREATE UNIQUE INDEX `UQ_player_edition_stats_playerid_eventid` ON `player_edition_stats` (`player_id`, `event_id`);

/*
# Foreign Key definitions
*/
ALTER TABLE `web_users` ADD FOREIGN KEY (`tm20_player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `web_users` ADD FOREIGN KEY (`tmnf_player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `world_records` ADD FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`);
ALTER TABLE `finishes` ADD FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`);
ALTER TABLE `finishes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `event_finishes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `event_finishes` ADD FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`);
ALTER TABLE `maps` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);
ALTER TABLE `player_edition_stats` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `player_edition_stats` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);
ALTER TABLE `user_metadata` ADD FOREIGN KEY (`user_id`) REFERENCES `web_users` (`id`);
ALTER TABLE `karma_votes` ADD FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`);
ALTER TABLE `karma_votes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);

/*
# Add all testing mocks below!
*/

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


/*
# Events mock (one TMNF one TM2020)
*/
INSERT INTO events (id, edition, game_type, starts_at, ends_at) VALUES (1, 10, "KK", CURRENT_TIMESTAMP, TIMESTAMPADD(MONTH, 1, CURRENT_TIMESTAMP));
INSERT INTO events (id, edition, game_type, starts_at, ends_at) VALUES (2, 5, "KR", CURRENT_TIMESTAMP, TIMESTAMPADD(MONTH, 1, CURRENT_TIMESTAMP));

/*
# Maps mock (TMNF)
*/
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (1, "I7rI7jAga6C4tGAe5OTDoyLF2fh", 1, "A05-Race", 5, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (2, "TteOqSjrhVsdjZYAaLuGBWX2a4c", 1, "A09-Race", 9, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (3, "KDBPTuNkrZG6jMxuRqmDBbLjfp6", 1, "A08-Endurance", 8, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (4, "KzeBzLOI62lxu3haZCPFn_4BfD6", 1, "A07-Race", 7, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (5, "zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 1, "A12-Speed", 12, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (6, "syko1DvAxleoVlqMsc1sJzqbt66", 1, "A06-Obstacle", 6, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (7, "mWxQhvvPOoNfPaq18j3dokLqyO7", 1, "A03-Race", 3, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (8, "JwKdDsOUh4L9_eYyRsdiA2o1fW1", 1, "A02-Race", 2, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (9, "6ktPCqLADXXuy5LaOLTzktaGlKf", 1, "A14-Race", 14, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (10, "BeySZdnfuSh4nHY5xztiXLmlrXe", 1, "A01-Race", 1, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (11, "jH8X3qPtpn6pj3dLAaq08pyDdp1", 1, "A10-Acrobatic", 10, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (12, "N0CpLabOm8Kk6Lsf0kwelgHiMQm", 1, "A11-Race", 11, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (13, "SEHmwPJVBl3NpHS56w6Sirac2Ic", 1, "A04-Acrobatic", 4, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (14, "K27AW3HYV47qqqXentunIoUERu8", 1, "A13-Race", 13, "Nadeo", 54321);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (15, "dJQvN8hB18o3SXNl897MOShzZQ5", 1, "A15-Speed", 15, "Nadeo", 54321);

/*
# Maps mock (TM20)
*/
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (16, "6y_26o7fxz0Es3t0e0EPBE7vF_k", 2, "Spring 2024 - 02", 2, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (17, "zmGw8qZpyugRtoRjIzv94NJEt00", 2, "Spring 2024 - 15", 15, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (18, "jHJiEQ2HARFfrj4llyscCEajxla", 2, "Spring 2024 - 19", 19, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (19, "dQHEGKXg1PcUDL8pI5YGOfHtyum", 2, "Spring 2024 - 24", 24, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (20, "_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 2, "Spring 2024 - 17", 17, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (21, "Qu0RAm2OEVhA8PtlHygSvwAP6af", 2, "Spring 2024 - 03", 3, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (22, "YnTMlq4EWuhP_3t07V1ltFN1d9i", 2, "Spring 2024 - 10", 10, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (23, "OoIkCPCGS03kGSUVLdYQFYXp8z1", 2, "Spring 2024 - 07", 7, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (24, "Dvta7ireTIDL0eM8yr41A9Bqrhj", 2, "Spring 2024 - 11", 11, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (25, "bPpUQZuGgy56BE4ST2e9lb3Ln66", 2, "Spring 2024 - 25", 25, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (26, "u7DgMxUjOS3QMoo6RK41_wVwUo8", 2, "Spring 2024 - 12", 12, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (27, "23TjgtcgWtsOT8c8_YXmStk9yT1", 2, "Spring 2024 - 22", 22, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (28, "lhLGScZNfT71Ti36T12QthclEx", 2, "Spring 2024 - 06", 6, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (29, "yQ4ktCXu3SAxyRx9gar8hj7kVBb", 2, "Spring 2024 - 01", 1, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (30, "gLjlftQPuk5kBY2dpiabyAxXt2l", 2, "Spring 2024 - 05", 5, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (31, "iX8qS5DXRjfaMqxYcToN75oXxzj", 2, "Spring 2024 - 18", 18, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (32, "cg6LF9Dgogww_hL0I9rGoC4oXDb", 2, "Spring 2024 - 04", 4, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (33, "8zvR_6FvQnEAUs_Ng4mCDwkEe53", 2, "Spring 2024 - 20", 20, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (34, "16SHL4He1HX73RGnwg1gw0XnVk5", 2, "Spring 2024 - 14", 14, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (35, "ANp_5I0olt_0vmies5vdxLkH1e2", 2, "Spring 2024 - 16", 16, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (36, "23qJ3GhkSPunIOi6hJGi53kN7Z6", 2, "Spring 2024 - 13", 13, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (37, "mz96XbMuvGhHuAzHWWu_8Csfzb9", 2, "Spring 2024 - 21", 21, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (38, "2BlomISK77gQVgS6IvPahcbtEBm", 2, "Spring 2024 - 09", 9, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (39, "k4TKkf1JSlWTEEZdCc9UCNTokk6", 2, "Spring 2024 - 08", 8, "Nadeo", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (40, "zNvVW_NnRdxDIQm6T6EbPDkYg20", 2, "Spring 2024 - 23", 23, "Nadeo", 23456);

/*
# debug maps (both games)
*/
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (41, "EdbzfLXMS_aI_PjZCVaygQ", 1, "debugmap2", 2, "reaby", 23456);
INSERT INTO maps (id, uuid, event_id, full_name, number, author, author_time) VALUES (42, "pdEB384l2w_r51Vz8T4txF8WJ7i", 2, "debugmap1", 1, "reaby", 23456);

/*
# karma votes mock
*/
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (1, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (1, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (1, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (1, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (1, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (2, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (2, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (2, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (2, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (2, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (3, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (3, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (3, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (3, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (3, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (4, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (4, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (4, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (4, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (4, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (5, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (5, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (5, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (5, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (5, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (6, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (6, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (6, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (6, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (6, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (7, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (7, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (7, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (7, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (7, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (8, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (8, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (8, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (8, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (8, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (9, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (9, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (9, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (9, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (9, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (10, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (10, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (10, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (10, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (10, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (11, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (11, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (11, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (11, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (11, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (12, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (12, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (12, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (12, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (12, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (13, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (13, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (13, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (13, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (13, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (14, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (14, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (14, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (14, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (14, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (15, 10, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (15, 11, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (15, 12, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (15, 13, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (15, 14, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (16, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (16, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (16, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (16, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (16, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (17, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (17, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (17, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (17, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (17, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (18, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (18, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (18, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (18, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (18, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (19, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (19, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (19, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (19, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (19, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (20, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (20, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (20, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (20, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (20, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (21, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (21, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (21, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (21, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (21, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (22, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (22, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (22, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (22, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (22, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (23, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (23, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (23, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (23, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (23, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (24, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (24, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (24, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (24, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (24, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (25, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (25, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (25, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (25, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (25, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (26, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (26, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (26, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (26, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (26, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (27, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (27, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (27, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (27, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (27, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (28, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (28, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (28, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (28, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (28, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (29, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (29, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (29, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (29, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (29, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (30, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (30, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (30, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (30, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (30, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (31, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (31, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (31, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (31, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (31, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (32, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (32, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (32, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (32, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (32, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (33, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (33, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (33, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (33, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (33, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (34, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (34, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (34, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (34, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (34, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (35, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (35, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (35, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (35, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (35, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (36, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (36, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (36, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (36, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (36, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (37, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (37, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (37, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (37, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (37, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (38, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (38, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (38, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (38, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (38, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (39, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (39, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (39, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (39, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (39, 19, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (40, 15, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (40, 16, -1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (40, 17, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (40, 18, 1);
INSERT INTO karma_votes (map_id, player_id, vote) VALUES (40, 19, 1);

/*
# player_edition_stats mock
*/
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(10, 67.863, 0, 1);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(11, 5.457, 2, 1);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(12, 174.039, 8, 1);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(13, 778.813, 5, 1);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(14, 617.835, 14, 1);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(15, 208.892, 18, 2);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(16, 24.843, 17, 2);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(17, 297.746, 1, 2);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(18, 81.159, 21, 2);
INSERT INTO player_edition_stats (player_id, average, finishes, event_id) VALUES(19, 184.737, 21, 2);

/*
# finishes mock
*/
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(1, 10, 15584, 12);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(1, 11, 24654, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(1, 12, 58117, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(1, 13, 35143, 7);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(1, 14, 56081, 15);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(3, 10, 14546, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(3, 11, 94012, 9);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(4, 10, 56975, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(5, 10, 34415, 3);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(5, 11, 73324, 12);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(5, 12, 72722, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(5, 13, 66768, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(5, 14, 80728, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(6, 10, 63100, 5);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(6, 11, 37733, 20);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(6, 12, 52464, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(6, 13, 96826, 5);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(7, 10, 28640, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(7, 11, 25084, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(7, 12, 33901, 9);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(8, 10, 12811, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(8, 11, 93700, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(8, 12, 34737, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(8, 13, 65912, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(9, 10, 52255, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(9, 11, 94283, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(10, 10, 68651, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(11, 10, 67892, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(11, 11, 68007, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(11, 12, 84470, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(11, 13, 44549, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(11, 14, 32001, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(12, 10, 29437, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(13, 10, 32766, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(13, 11, 71908, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(13, 12, 66859, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(14, 10, 49856, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(14, 11, 84018, 12);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(14, 12, 79159, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(15, 10, 82252, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(15, 11, 78006, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(15, 12, 41991, 18);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(15, 13, 20109, 12);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(15, 14, 42794, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(16, 15, 29609, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(16, 16, 43060, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(18, 15, 48477, 20);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(18, 16, 90715, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(18, 17, 43194, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(18, 18, 18095, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(19, 15, 16110, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(20, 15, 75943, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(20, 16, 85901, 18);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(21, 15, 27100, 3);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(21, 16, 95692, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(22, 15, 37529, 20);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(22, 16, 37232, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(22, 17, 92813, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(22, 18, 21241, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(22, 19, 78724, 5);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(23, 15, 95049, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(23, 16, 30814, 5);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(23, 17, 81252, 18);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(24, 15, 34609, 5);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(24, 16, 95066, 3);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(24, 17, 89479, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(25, 15, 54983, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(25, 16, 51372, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(25, 17, 44608, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(25, 18, 68505, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(26, 15, 89130, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(26, 16, 53999, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(26, 17, 27983, 7);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(26, 18, 67796, 20);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(27, 15, 14529, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(27, 16, 92168, 6);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(28, 15, 69579, 17);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(28, 16, 18423, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(28, 17, 15004, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(28, 18, 37750, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(28, 19, 25715, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(29, 15, 18697, 2);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(29, 16, 19743, 9);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(30, 15, 49566, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(31, 15, 32168, 7);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(31, 16, 82528, 7);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(31, 17, 55524, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(31, 18, 36264, 3);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(31, 19, 26442, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(32, 15, 13723, 15);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(32, 16, 74727, 3);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(32, 17, 69432, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(33, 15, 11983, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(33, 16, 20639, 8);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(33, 17, 79385, 10);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(34, 15, 64105, 15);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(34, 16, 85027, 18);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(35, 15, 67916, 11);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(36, 15, 32382, 12);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(36, 16, 46197, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(37, 15, 97602, 19);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(37, 16, 66881, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(38, 15, 55183, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(38, 16, 27732, 9);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(38, 17, 78891, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(38, 18, 41360, 14);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(39, 15, 80739, 1);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(39, 16, 64586, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(39, 17, 18777, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(39, 18, 25243, 4);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(40, 15, 45721, 16);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(40, 16, 98193, 13);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(40, 17, 75348, 11);
INSERT INTO finishes (map_id, player_id, score, finish_counter) VALUES(40, 18, 56565, 1);