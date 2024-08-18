IMAGE_NAME:=node-hello-world
CONTAINER_NAME:=node-hello-world

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
HOST_PORT := 8080
PORT := 3000

app-build-image:
	cd application && docker build -t $(IMAGE_NAME) .

app-dive:
	dive $(IMAGE_NAME)

app-run-local:
	docker run \
		--rm \
		-e HOST_UID=$(CURRENT_UID) \
		-e HOST_GID=$(CURRENT_GID) \
		-e PORT=$(PORT) \
		-p $(HOST_PORT):$(PORT) \
		$(IMAGE_NAME)app-kill-local:
app-kill-local:
	docker kill $(CONTAINER_NAME)