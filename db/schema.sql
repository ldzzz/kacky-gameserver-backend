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
