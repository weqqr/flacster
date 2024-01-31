include config.mk

.PHONY: backend
backend:
	$(MAKE) -C ui build
	rm -rf static && cp -r ui/build static
	go build

.PHONY: golint
golint:
	golangci-lint run ./...

.PHONY: build
build:
	docker-compose build

.PHONY: up
up:
	docker-compose -f $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_OVERRIDE) up -d

.PHONY: createdb
createdb:
	docker exec \
	-it $(CONTAINER_NAME) createdb \
	--username=$(POSTGRES_USERNAME) \
	--owner=$(POSTGRES_OWNER) \
	$(DB_NAME)

.PHONY: dropdb
dropdb:
	docker exec \
	-it $(CONTAINER_NAME) dropbd \
	$(DB_NAME)

.PHONY: down
down:
	docker-compose down

.PHONY: migrateup
migrateup:
	migrate -path $(MIGRATION_PATH) \
 	-database $(DB_CONNECTION_STRING) -verbose up

.PHONY: migrateup1
migrateup1:
	migrate -path $(MIGRATION_PATH) \
 	-database $(DB_CONNECTION_STRING) -verbose up 1

.PHONY: migratedown
migratedown:
	migrate -path $(MIGRATION_PATH) \
	-database $(DB_CONNECTION_STRING) -verbose down

.PHONY: migratedown1
migratedown1:
	migrate -path $(MIGRATION_PATH) \
	-database $(DB_CONNECTION_STRING) -verbose down 1

.PHONY: logs
logs:
	docker-compose logs

.PHONY: gosec
gosec:
	gosec ./...

.PHONY: all
all: backend
