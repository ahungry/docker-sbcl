all: ahungry/sbcl


$(shell echo "`sha256sum Dockerfile | cut -f1 -d' '`.checksum"):
	docker build -t ahungry/sbcl .
	touch $@

ahungry/sbcl: $(shell echo "`sha256sum Dockerfile | cut -f1 -d' '`.checksum")

start: ahungry/sbcl
	docker run --rm -i -t ahungry/sbcl

.PHONY: start
