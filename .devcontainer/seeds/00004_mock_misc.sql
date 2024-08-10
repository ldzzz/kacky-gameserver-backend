-- +goose Up
-- +goose StatementBegin
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



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM karma_votes;
ALTER TABLE karma_votes AUTO_INCREMENT = 1;
DELETE FROM player_edition_stats;
ALTER TABLE player_edition_stats AUTO_INCREMENT = 1;
-- +goose StatementEnd
