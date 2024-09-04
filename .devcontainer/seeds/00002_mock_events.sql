-- +goose Up
-- +goose StatementBegin

/*
# Events mock (one TMNF one TM2020)
*/
INSERT INTO events (id, edition, game_type, starts_at, ends_at) VALUES (1, 10, "KK", CURRENT_TIMESTAMP, TIMESTAMPADD(MONTH, 1, CURRENT_TIMESTAMP));
INSERT INTO events (id, edition, game_type, starts_at, ends_at) VALUES (2, 5, "KR", CURRENT_TIMESTAMP, TIMESTAMPADD(MONTH, 1, CURRENT_TIMESTAMP));

/*
# Maps mock (TMNF)
*/
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (1,  "BeySZdnfuSh4nHY5xztiXLmlrXe", 1, "A01-Race",      1,  "Nadeo", 24540);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (2,  "JwKdDsOUh4L9_eYyRsdiA2o1fW1", 1, "A02-Race",      2,  "Nadeo", 16250);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (3,  "mWxQhvvPOoNfPaq18j3dokLqyO7", 1, "A03-Race",      3,  "Nadeo", 18750);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (4,  "SEHmwPJVBl3NpHS56w6Sirac2Ic", 1, "A04-Acrobatic", 4,  "Nadeo", 5950);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (5,  "I7rI7jAga6C4tGAe5OTDoyLF2fh", 1, "A05-Race",      5,  "Nadeo", 16910);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (6,  "syko1DvAxleoVlqMsc1sJzqbt66", 1, "A06-Obstacle",  6,  "Nadeo", 28580);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (7,  "KzeBzLOI62lxu3haZCPFn_4BfD6", 1, "A07-Race",      7,  "Nadeo", 29140);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (8,  "KDBPTuNkrZG6jMxuRqmDBbLjfp6", 1, "A08-Endurance", 8,  "Nadeo", 64480);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (9,  "TteOqSjrhVsdjZYAaLuGBWX2a4c", 1, "A09-Race",      9,  "Nadeo", 25980);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (10, "jH8X3qPtpn6pj3dLAaq08pyDdp1", 1, "A10-Acrobatic", 10, "Nadeo", 9650);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (11, "N0CpLabOm8Kk6Lsf0kwelgHiMQm", 1, "A11-Race",      11, "Nadeo", 19320);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (12, "zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 1, "A12-Speed",     12, "Nadeo", 19090);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (13, "K27AW3HYV47qqqXentunIoUERu8", 1, "A13-Race",      13, "Nadeo", 31700);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (14, "6ktPCqLADXXuy5LaOLTzktaGlKf", 1, "A14-Race",      14, "Nadeo", 22170);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (15, "dJQvN8hB18o3SXNl897MOShzZQ5", 1, "A15-Speed",     15, "Nadeo", 25330);

/*
# Maps mock (TM20)
*/
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (16, "olsKnq_qAghcVAnEkoeUnVHFZei", 2, "Training - 01", 1,  "Nadeo", 7528);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (17, "btmbJWADQOS20ginP9DJ0i8sh3f", 2, "Training - 02", 2,  "Nadeo", 7120);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (18, "lNP8O0sqatiHqecUXrhH65rpQ8a", 2, "Training - 03", 3,  "Nadeo", 8305);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (19, "ga3zTKvSo7yJca60Ry_Z003L031", 2, "Training - 04", 4,  "Nadeo", 7513);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (20, "xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 2, "Training - 05", 5,  "Nadeo", 10546);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (21, "LcBa4OZLeElnJksgbBEpQggitsh", 2, "Training - 06", 6,  "Nadeo", 11307);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (22, "vTqUpE1iiXupNABp5Mfx0YOf33j", 2, "Training - 07", 7,  "Nadeo", 8306);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (23, "OeJCW8sHENIcYscK8o5zVHAxADd", 2, "Training - 08", 8,  "Nadeo", 11958);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (24, "us4gaCDQSxmjVMtp5nYfReezTqh", 2, "Training - 09", 9,  "Nadeo", 12217);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (25, "DyNBxhQ6006991FwvVOaBX9Gcv1", 2, "Training - 10", 10, "Nadeo", 11750);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (26, "PhJGvGjkCaw299rBhVsEhNJKX1",  2, "Training - 11", 11, "Nadeo", 5053);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (27, "AJFJd6yABuSMfgJGc8UpWRwUVa0", 2, "Training - 12", 12, "Nadeo", 11340);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (28, "Nw8BZ8CtZZcFO547WnqdPzp8ydi", 2, "Training - 13", 13, "Nadeo", 12260);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (29, "eOA1X_xnvKbdDSuyymweOZzSrQ3", 2, "Training - 14", 14, "Nadeo", 12217);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (30, "0hI2P3y8sENgIkruI_X7s3efES",  2, "Training - 15", 15, "Nadeo", 13484);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (31, "RlZ2HVhAwN5nD7I1lLciKhPsbb7", 2, "Training - 16", 16, "Nadeo", 15954);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (32, "EnMnBg3D4Uvb5bz8VLod73z6n47", 2, "Training - 17", 17, "Nadeo", 18177);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (33, "TVUF91YlnL78BFJwG5ADkNlymqe", 2, "Training - 18", 18, "Nadeo", 16304);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (34, "SsCdL6nGC__n8UrYnsX8xaqnjCh", 2, "Training - 19", 19, "Nadeo", 18134);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (35, "Yakz8xDlVWDfVCfXxW2_paCaHil", 2, "Training - 20", 20, "Nadeo", 26725);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (36, "f1tlOzXvdELVhwrhPpoJDsg9xs8", 2, "Training - 21", 21, "Nadeo", 16677);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (37, "OHRxJCE_cKxEGOGmhF9z6Hf0YZb", 2, "Training - 22", 22, "Nadeo", 18542);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (38, "qQEgNKxDhXtTsxWYRW0V4pvpER7", 2, "Training - 23", 23, "Nadeo", 23153);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (39, "1rwAkLrbqhN47zCsVvJJFJimlcf", 2, "Training - 24", 24, "Nadeo", 19484);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (40, "TkyKsOEG7gHqVqjjc3A1Qj5rPgi", 2, "Training - 25", 25, "Nadeo", 36363);

/*
# debug maps (both games)
*/
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (41, "EdbzfLXMS_aI_PjZCVaygQ", 1, "debugmap2", 2, "reaby", 23456);
INSERT INTO maps (id, map_uid, event_id, full_name, number, author, author_time) VALUES (42, "pdEB384l2w_r51Vz8T4txF8WJ7i", 2, "debugmap1", 1, "reaby", 23456);


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM events;
ALTER TABLE events AUTO_INCREMENT = 1;
DELETE FROM maps;
ALTER TABLE maps AUTO_INCREMENT = 1;
-- +goose StatementEnd
