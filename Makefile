IMAGE_NAME:=node-hello-world
CONTAINER_NAME:=node-hello-world

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
HOST_PORT := 8080
APP_PORT := 8080

app-build-image:
	cd application && docker build -t $(IMAGE_NAME) .

app-dive:
	dive $(IMAGE_NAME)

app-run-local:
	docker run \
		--rm \
		-e HOST_UID=$(CURRENT_UID) \
		-e HOST_GID=$(CURRENT_GID) \
		-e PORT=$(APP_PORT) \
		-p $(HOST_PORT):$(APP_PORT) \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME)

app-tty-local:
	docker run \
		--rm \
		-it \
		-e HOST_UID=$(CURRENT_UID) \
		-e HOST_GID=$(CURRENT_GID) \
		-e PORT=$(APP_PORT) \
		-p $(HOST_PORT):$(APP_PORT) \
		--name $(CONTAINER_NAME) \
		--entrypoint /bin/bash \
		$(IMAGE_NAME)

app-kill-local:
	docker kill $(CONTAINER_NAME)