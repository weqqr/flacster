.PHONY: all
all:
	go build ./cmd/flacster

.PHONY: lint
lint:
	golangci-lint run

