.PHONY: build push vars

DOCKER_IMAGE ?= bravado/softether

default: build

init:
	$(eval DOCKER_TAG=$(shell git rev-parse --abbrev-ref HEAD))
	$(if $(subst master,,${DOCKER_TAG}),, $(eval DOCKER_TAG=latest))

vars: init
	@echo ${DOCKER_IMAGE}:${DOCKER_TAG}

build: init
	docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

bash: build
	docker run -it --rm --entrypoint bash ${DOCKER_IMAGE}:${DOCKER_TAG}

run: build
	docker run -d --name vpnserver -P ${DOCKER_IMAGE}:${DOCKER_TAG}
