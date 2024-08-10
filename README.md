# kacky-server-backend

Backend for the game servers

actual migrations
goose up

for mocks
goose -dir ${SEEDS_MIGRATION_DIR} --no-versioning up
goose -dir ${SEEDS_MIGRATION_DIR} --no-versioning reset
