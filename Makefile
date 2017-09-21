default: build

DOCKER_IMAGE ?= bluedrop360/helm-runner
DOCKER_TAG ?= latest

build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	
push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
