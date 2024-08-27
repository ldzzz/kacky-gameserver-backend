-- +goose Up
-- +goose StatementBegin
/*
* webserver relevant tables
*/

CREATE TABLE `web_users` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `discord_login` VARCHAR(255) UNIQUE NOT NULL,
  `tm20_player_id` BIGINT,
  `tmnf_player_id` BIGINT,
  `role` VARCHAR(255) DEFAULT 'user',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `user_metadata` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `web_user_id` BIGINT UNIQUE,
  `tmnf_player_id` BIGINT UNIQUE,
  `tm20_player_id` BIGINT UNIQUE,
  `stream_data` JSON,
  `tags` JSON,
  `difficulties` JSON,
  `alarms` JSON,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `api_keys` (
  `id` bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


/*
* Gameserver relevant tables
*/

CREATE TABLE `tm_players` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(255) NOT NULL,
  `game_type` VARCHAR(255) NOT NULL,
  `zone` VARCHAR(255) NOT NULL,
  `total_playtime` INT NOT NULL DEFAULT 0,
  `nickname` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL DEFAULT 'user',
  `is_muted` TINYINT NOT NULL DEFAULT 0,
  `is_blacklisted` TINYINT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `maps` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_uid` VARCHAR(255) NOT NULL,
  `event_id` BIGINT NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `number` INT NOT NULL,
  `author` VARCHAR(255) NOT NULL,
  `author_time` INT NOT NULL,
  `total_playtime` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `karma_votes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_uid` VARCHAR(255) NOT NULL,
  `player_id` BIGINT NOT NULL,
  `vote` DOUBLE NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `world_records` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_uid` VARCHAR(255) UNIQUE NOT NULL,
  `wr_holder` VARCHAR(255) NOT NULL,
  `score` INT NOT NULL,
  `source` VARCHAR(255) NOT NULL,
  `driven_at` TIMESTAMP NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `finishes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_uid` VARCHAR(255) NOT NULL,
  `player_id` BIGINT NOT NULL,
  `score` INT NOT NULL,
  `finish_counter` INT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_improved_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `event_finishes` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `map_uid` VARCHAR(255) NOT NULL,
  `player_id` BIGINT NOT NULL,
  `score` INT NOT NULL,
  `finish_counter` INT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_improved_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `events` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `edition` int NOT NULL,
  `game_type` VARCHAR(255) NOT NULL,
  `starts_at` TIMESTAMP NOT NULL,
  `ends_at` TIMESTAMP NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `player_edition_stats` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `player_id` BIGINT NOT NULL,
  `average` DOUBLE NOT NULL DEFAULT 0,
  `finishes` INT NOT NULL DEFAULT 0,
  `event_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `event_player_edition_stats` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `player_id` BIGINT NOT NULL,
  `average` DOUBLE NOT NULL DEFAULT 0,
  `finishes` INT NOT NULL DEFAULT 0,
  `event_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `servers` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(255) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `game_type` VARCHAR(255) NOT NULL,
  `difficulty` INT NOT NULL DEFAULT 0,
  `time_limit` INT NOT NULL DEFAULT 10,
  `current_map_info` JSON NULL,
  `next_maps` JSON NULL,
  `map_list` JSON NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

/*
# Unique constraints definitions
# in format UQ_<table>_<col1>_<col2>
*/
ALTER TABLE `tm_players` ADD CONSTRAINT `UQ_tm_players_login_gametype` UNIQUE (`login`, `game_type`);
ALTER TABLE `maps` ADD CONSTRAINT `UQ_maps_index_uuid_eventid` UNIQUE (`map_uid`, `event_id`);
ALTER TABLE `karma_votes` ADD CONSTRAINT `UQ_karma_votes_mapid_playerid` UNIQUE (`map_uid`, `player_id`);
ALTER TABLE `finishes` ADD CONSTRAINT `UQ_finishes_mapid_playerid` UNIQUE (`map_uid`, `player_id`);
ALTER TABLE `event_finishes` ADD CONSTRAINT `UQ_event_finishes_mapid_playerid` UNIQUE (`map_uid`, `player_id`);
ALTER TABLE `events` ADD CONSTRAINT `UQ_events_edition_gametype` UNIQUE (`edition`, `game_type`);
ALTER TABLE `servers` ADD CONSTRAINT `UQ_servers_login_gametype` UNIQUE (`login`, `game_type`);
ALTER TABLE `player_edition_stats` ADD CONSTRAINT `UQ_player_edition_stats_playerid_eventid` UNIQUE (`player_id`, `event_id`);
ALTER TABLE `event_player_edition_stats` ADD CONSTRAINT `UQ_event_player_edition_stats_playerid_eventid` UNIQUE (`player_id`, `event_id`);


/*
# Foreign Key definitions
*/
ALTER TABLE `web_users` ADD FOREIGN KEY (`tm20_player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `web_users` ADD FOREIGN KEY (`tmnf_player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `world_records` ADD FOREIGN KEY (`map_uid`) REFERENCES `maps` (`map_uid`) ON DELETE CASCADE;
ALTER TABLE `finishes` ADD FOREIGN KEY (`map_uid`) REFERENCES `maps` (`map_uid`) ON DELETE CASCADE;
ALTER TABLE `finishes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `event_finishes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `event_finishes` ADD FOREIGN KEY (`map_uid`) REFERENCES `maps` (`map_uid`) ON DELETE CASCADE;
ALTER TABLE `maps` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;
ALTER TABLE `player_edition_stats` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `player_edition_stats` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;
ALTER TABLE `event_player_edition_stats` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
ALTER TABLE `event_player_edition_stats` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;
ALTER TABLE `karma_votes` ADD FOREIGN KEY (`map_uid`) REFERENCES `maps` (`map_uid`) ON DELETE CASCADE;
ALTER TABLE `karma_votes` ADD FOREIGN KEY (`player_id`) REFERENCES `tm_players` (`id`);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SET FOREIGN_KEY_CHECKS=0; -- to disable them
DROP TABLE IF EXISTS tm_players;
DROP TABLE IF EXISTS maps;
DROP TABLE IF EXISTS servers;
DROP TABLE IF EXISTS user_metadata;
DROP TABLE IF EXISTS finishes;
DROP TABLE IF EXISTS web_users;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS event_finishes;
DROP TABLE IF EXISTS world_records;
DROP TABLE IF EXISTS event_player_edition_stats;
DROP TABLE IF EXISTS player_edition_stats;
DROP TABLE IF EXISTS karma_votes;
DROP TABLE IF EXISTS api_keys;
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
-- +goose StatementEnd
