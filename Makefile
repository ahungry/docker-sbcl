all: ahungry/sbcl ahungry/sbcl-with-core

ahungry/sbcl-with-core: Dockerfile-sbcl-with-core
	docker build -f Dockerfile-sbcl-with-core -t ahungry/sbcl-with-core .

ahungry/sbcl: Dockerfile
	docker build -t ahungry/sbcl .

start: ahungry/sbcl
	docker run --rm -i -t ahungry/sbcl

.PHONY: start
