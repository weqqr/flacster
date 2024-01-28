include config.mk

.PHONY: backend
backend:
	$(MAKE) -C ui build
	rm -rf static && cp -r ui/build static
	go build

.PHONY: createdb
createdb:
	docker exec \
	-it $(CONTAINER_NAME) createdb \
	--username=$(POSTGRES_USERNAME) \
	--owner=$(POSTGRES_OWNER) \
	$(DB_NAME) || true

.PHONY: golint
golint:
	golangci-lint run ./...

.PHONY: up
up:
	docker-compose -f $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_OVERRIDE) up -d

.PHONY: down
down:
	docker-compose down

.PHONY: logs
logs:
	docker-compose logs

.PHONY: gosec
gosec:
	gosec ./...

.PHONY: all init
all: up
init: createdb
