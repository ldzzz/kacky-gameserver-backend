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
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("I7rI7jAga6C4tGAe5OTDoyLF2fh", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("I7rI7jAga6C4tGAe5OTDoyLF2fh", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("I7rI7jAga6C4tGAe5OTDoyLF2fh", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("I7rI7jAga6C4tGAe5OTDoyLF2fh", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("I7rI7jAga6C4tGAe5OTDoyLF2fh", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("TteOqSjrhVsdjZYAaLuGBWX2a4c", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("TteOqSjrhVsdjZYAaLuGBWX2a4c", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("TteOqSjrhVsdjZYAaLuGBWX2a4c", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("TteOqSjrhVsdjZYAaLuGBWX2a4c", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("TteOqSjrhVsdjZYAaLuGBWX2a4c", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KDBPTuNkrZG6jMxuRqmDBbLjfp6", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KDBPTuNkrZG6jMxuRqmDBbLjfp6", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KDBPTuNkrZG6jMxuRqmDBbLjfp6", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KDBPTuNkrZG6jMxuRqmDBbLjfp6", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KDBPTuNkrZG6jMxuRqmDBbLjfp6", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KzeBzLOI62lxu3haZCPFn_4BfD6", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KzeBzLOI62lxu3haZCPFn_4BfD6", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KzeBzLOI62lxu3haZCPFn_4BfD6", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KzeBzLOI62lxu3haZCPFn_4BfD6", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("KzeBzLOI62lxu3haZCPFn_4BfD6", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zwAbNlFSDcXjRBk0YSMyxc5kJJ8", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("syko1DvAxleoVlqMsc1sJzqbt66", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("syko1DvAxleoVlqMsc1sJzqbt66", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("syko1DvAxleoVlqMsc1sJzqbt66", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("syko1DvAxleoVlqMsc1sJzqbt66", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("syko1DvAxleoVlqMsc1sJzqbt66", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("mWxQhvvPOoNfPaq18j3dokLqyO7", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("mWxQhvvPOoNfPaq18j3dokLqyO7", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("mWxQhvvPOoNfPaq18j3dokLqyO7", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("mWxQhvvPOoNfPaq18j3dokLqyO7", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("mWxQhvvPOoNfPaq18j3dokLqyO7", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("JwKdDsOUh4L9_eYyRsdiA2o1fW1", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("JwKdDsOUh4L9_eYyRsdiA2o1fW1", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("JwKdDsOUh4L9_eYyRsdiA2o1fW1", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("JwKdDsOUh4L9_eYyRsdiA2o1fW1", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("JwKdDsOUh4L9_eYyRsdiA2o1fW1", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6ktPCqLADXXuy5LaOLTzktaGlKf", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6ktPCqLADXXuy5LaOLTzktaGlKf", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6ktPCqLADXXuy5LaOLTzktaGlKf", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6ktPCqLADXXuy5LaOLTzktaGlKf", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6ktPCqLADXXuy5LaOLTzktaGlKf", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("BeySZdnfuSh4nHY5xztiXLmlrXe", 10, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("BeySZdnfuSh4nHY5xztiXLmlrXe", 11, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("BeySZdnfuSh4nHY5xztiXLmlrXe", 12, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("BeySZdnfuSh4nHY5xztiXLmlrXe", 13, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("BeySZdnfuSh4nHY5xztiXLmlrXe", 14, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6y_26o7fxz0Es3t0e0EPBE7vF_k", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6y_26o7fxz0Es3t0e0EPBE7vF_k", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6y_26o7fxz0Es3t0e0EPBE7vF_k", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6y_26o7fxz0Es3t0e0EPBE7vF_k", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("6y_26o7fxz0Es3t0e0EPBE7vF_k", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zmGw8qZpyugRtoRjIzv94NJEt00", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zmGw8qZpyugRtoRjIzv94NJEt00", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zmGw8qZpyugRtoRjIzv94NJEt00", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zmGw8qZpyugRtoRjIzv94NJEt00", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("zmGw8qZpyugRtoRjIzv94NJEt00", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("jHJiEQ2HARFfrj4llyscCEajxla", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("jHJiEQ2HARFfrj4llyscCEajxla", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("jHJiEQ2HARFfrj4llyscCEajxla", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("jHJiEQ2HARFfrj4llyscCEajxla", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("jHJiEQ2HARFfrj4llyscCEajxla", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("dQHEGKXg1PcUDL8pI5YGOfHtyum", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("dQHEGKXg1PcUDL8pI5YGOfHtyum", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("dQHEGKXg1PcUDL8pI5YGOfHtyum", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("dQHEGKXg1PcUDL8pI5YGOfHtyum", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("dQHEGKXg1PcUDL8pI5YGOfHtyum", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("_oXHWr6nTCmZTUoLsLcC6Qn8VJl", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Qu0RAm2OEVhA8PtlHygSvwAP6af", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Qu0RAm2OEVhA8PtlHygSvwAP6af", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Qu0RAm2OEVhA8PtlHygSvwAP6af", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Qu0RAm2OEVhA8PtlHygSvwAP6af", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Qu0RAm2OEVhA8PtlHygSvwAP6af", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("YnTMlq4EWuhP_3t07V1ltFN1d9i", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("YnTMlq4EWuhP_3t07V1ltFN1d9i", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("YnTMlq4EWuhP_3t07V1ltFN1d9i", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("YnTMlq4EWuhP_3t07V1ltFN1d9i", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("YnTMlq4EWuhP_3t07V1ltFN1d9i", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OoIkCPCGS03kGSUVLdYQFYXp8z1", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OoIkCPCGS03kGSUVLdYQFYXp8z1", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OoIkCPCGS03kGSUVLdYQFYXp8z1", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OoIkCPCGS03kGSUVLdYQFYXp8z1", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OoIkCPCGS03kGSUVLdYQFYXp8z1", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Dvta7ireTIDL0eM8yr41A9Bqrhj", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Dvta7ireTIDL0eM8yr41A9Bqrhj", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Dvta7ireTIDL0eM8yr41A9Bqrhj", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Dvta7ireTIDL0eM8yr41A9Bqrhj", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("Dvta7ireTIDL0eM8yr41A9Bqrhj", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("bPpUQZuGgy56BE4ST2e9lb3Ln66", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("bPpUQZuGgy56BE4ST2e9lb3Ln66", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("bPpUQZuGgy56BE4ST2e9lb3Ln66", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("bPpUQZuGgy56BE4ST2e9lb3Ln66", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("bPpUQZuGgy56BE4ST2e9lb3Ln66", 19, 1);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM karma_votes;
ALTER TABLE karma_votes AUTO_INCREMENT = 1;
DELETE FROM player_edition_stats;
ALTER TABLE player_edition_stats AUTO_INCREMENT = 1;
-- +goose StatementEnd
