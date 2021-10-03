VERSION=`cat VERSION`
DOCKER_CONTAINER=metaplex
DOCKER_IMAGE=popviz/${DOCKER_CONTAINER}

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docker
docker: docker-build docker-publish

.PHONY: docker-build
docker-build:	## Builds container and tag resulting image
	docker build --force-rm --tag ${DOCKER_IMAGE} .
	docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE}:$(VERSION)

.PHONY: docker-publish
docker-publish:	## Publishes container image to Dockerhub/Gitlab repo
	docker push ${DOCKER_IMAGE}:$(VERSION)
	docker push ${DOCKER_IMAGE}:latest

.DEFAULT_GOAL := help
