# kacky-server-backend

Kacky gameserver controller backend for all things Kacky!<br>
The backend handles all kacky gameserver controller connections through usage of [NATS](https://docs.nats.io/) and [request-response microservices](https://github.com/nats-io/nats.go/blob/main/micro/README.md).

## Documentation

Check out API documentation [here](/api/README.md).

## Development

The project is set-up to work with VSCode devcontainers. You can read more about it [here](https://code.visualstudio.com/docs/devcontainers/containers).<br> The development database is not persistent and will be lost when container volume is removed. <br> If you want to keep development database you need to mount named volume for the service container in `.devctonainer/docker-compose-dev.yml`.
Furthermore, the project uses [sqlc](https://github.com/sqlc-dev/sqlc) to generate database ORM functions from SQL code.

Following services are started via devcontainers:

- `development container`
- `database`
- `NATS`

Once the development container is up and running, you need to apply database migrations:

- `goose up`

To seed your database with mock data, you can use & modify seeds found in `.devcontainer/seeds/`folder.
The default mock seeds include TMNF - White campaign maps for TMNF and Spring 2024 for TM2020 map mock, additionally mocking finishes, karma, players, etc.
<br>
To apply/undo mock seed data following commands are available:

- `goose -dir ${SEEDS_MIGRATION_DIR} --no-versioning up`
- `goose -dir ${SEEDS_MIGRATION_DIR} --no-versioning reset`

## TODOs

- Write more detailed documentation and introduction
- Finish backend implementation
- Write tests
- Setup production dockerization
- Setup CI/CD
