NAME =			youtransfer
VERSION =		latest
VERSION_ALIASES =	1.0.5 1.0 1
TITLE =			YouTransfer
DESCRIPTION =		YouTransfer
SOURCE_URL =		https://github.com/scaleway-community/scaleway-youtransfer
VENDOR_URL =		http://www.youtransfer.io/

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		YouTransfer

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
