POSTGRES_USERNAME = admin
POSTGRES_OWNER = admin
DB_NAME = flacster
CONTAINER_NAME = db
DOCKER_COMPOSE = docker-compose.yml
DOCKER_COMPOSE_OVERRIDE = docker-compose.override.yml
MIGRATION_PATH = internal/db/migration
DB_CONNECTION_STRING = postgresql://admin:1234@localhost:5432/flacster?sslmode=disable