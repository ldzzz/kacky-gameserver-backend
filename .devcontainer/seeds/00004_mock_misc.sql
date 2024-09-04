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

INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("olsKnq_qAghcVAnEkoeUnVHFZei", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("olsKnq_qAghcVAnEkoeUnVHFZei", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("olsKnq_qAghcVAnEkoeUnVHFZei", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("olsKnq_qAghcVAnEkoeUnVHFZei", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("olsKnq_qAghcVAnEkoeUnVHFZei", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("btmbJWADQOS20ginP9DJ0i8sh3f", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("btmbJWADQOS20ginP9DJ0i8sh3f", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("btmbJWADQOS20ginP9DJ0i8sh3f", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("btmbJWADQOS20ginP9DJ0i8sh3f", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("btmbJWADQOS20ginP9DJ0i8sh3f", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("lNP8O0sqatiHqecUXrhH65rpQ8a", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("lNP8O0sqatiHqecUXrhH65rpQ8a", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("lNP8O0sqatiHqecUXrhH65rpQ8a", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("lNP8O0sqatiHqecUXrhH65rpQ8a", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("lNP8O0sqatiHqecUXrhH65rpQ8a", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("ga3zTKvSo7yJca60Ry_Z003L031", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("ga3zTKvSo7yJca60Ry_Z003L031", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("ga3zTKvSo7yJca60Ry_Z003L031", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("ga3zTKvSo7yJca60Ry_Z003L031", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("ga3zTKvSo7yJca60Ry_Z003L031", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("xSOA3Fs8k3bGNHFQhwskyAjN3Nh", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("LcBa4OZLeElnJksgbBEpQggitsh", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("LcBa4OZLeElnJksgbBEpQggitsh", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("LcBa4OZLeElnJksgbBEpQggitsh", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("LcBa4OZLeElnJksgbBEpQggitsh", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("LcBa4OZLeElnJksgbBEpQggitsh", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("vTqUpE1iiXupNABp5Mfx0YOf33j", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("vTqUpE1iiXupNABp5Mfx0YOf33j", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("vTqUpE1iiXupNABp5Mfx0YOf33j", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("vTqUpE1iiXupNABp5Mfx0YOf33j", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("vTqUpE1iiXupNABp5Mfx0YOf33j", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OeJCW8sHENIcYscK8o5zVHAxADd", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OeJCW8sHENIcYscK8o5zVHAxADd", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OeJCW8sHENIcYscK8o5zVHAxADd", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OeJCW8sHENIcYscK8o5zVHAxADd", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("OeJCW8sHENIcYscK8o5zVHAxADd", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("us4gaCDQSxmjVMtp5nYfReezTqh", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("us4gaCDQSxmjVMtp5nYfReezTqh", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("us4gaCDQSxmjVMtp5nYfReezTqh", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("us4gaCDQSxmjVMtp5nYfReezTqh", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("us4gaCDQSxmjVMtp5nYfReezTqh", 19, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("DyNBxhQ6006991FwvVOaBX9Gcv1", 15, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("DyNBxhQ6006991FwvVOaBX9Gcv1", 16, -1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("DyNBxhQ6006991FwvVOaBX9Gcv1", 17, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("DyNBxhQ6006991FwvVOaBX9Gcv1", 18, 1);
INSERT INTO karma_votes (map_uid, player_id, vote) VALUES ("DyNBxhQ6006991FwvVOaBX9Gcv1", 19, 1);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM karma_votes;
ALTER TABLE karma_votes AUTO_INCREMENT = 1;
DELETE FROM player_edition_stats;
ALTER TABLE player_edition_stats AUTO_INCREMENT = 1;
-- +goose StatementEnd
