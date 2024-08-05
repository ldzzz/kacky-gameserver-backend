-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';

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


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';

TRUNCATE events;
TRUNCATE maps;

-- +goose StatementEnd
