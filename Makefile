IMAGE_NAME:=node-hello-world

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
PORT := 7777

app-build-image:
	cd application && docker build -t $(IMAGE_NAME) .

app-dive:
	dive $(IMAGE_NAME)

app-run:
	docker run \
		-e HOST_UID=$(CURRENT_UID) \
		-e HOST_GID=$(CURRENT_GID) \
		-e PORT=$(PORT) \
		-p 8080:$(PORT) \
		$(IMAGE_NAME)