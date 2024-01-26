.PHONY: backend
backend:
	$(MAKE) -C ui build
	rm -r static && cp -r ui/build static
	go build

.PHONY: all
all: backend
