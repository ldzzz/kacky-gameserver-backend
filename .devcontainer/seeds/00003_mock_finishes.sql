-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';

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

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';

TRUNCATE finishes;

-- +goose StatementEnd
