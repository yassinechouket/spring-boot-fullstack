AWS_ACCOUNT_ID := 742460038063
AWS_DEFAULT_REGION := eu-west-3
AWS_ECR_DOMAIN := $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com
GIT_SHA := $(shell git rev-parse HEAD)
BUILD_IMAGE := $(AWS_ECR_DOMAIN)/spring-fullstack-frontend
BUILD_TAG := $(if $(BUILD_TAG),$(BUILD_TAG),latest)

.DEFAULT_GOAL := build

# --------------------
# Install + build React app
# --------------------
build:
	npm install
	npm run build

# --------------------
# Docker image build
# --------------------
build-image:
	docker buildx build --platform "linux/amd64" --tag "$(BUILD_IMAGE):$(GIT_SHA)" .

build-image-login:
	aws ecr get-login-password --region $(AWS_DEFAULT_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_DOMAIN)

build-image-push: build-image-login
	docker image push $(BUILD_IMAGE):$(GIT_SHA)

build-image-pull: build-image-login
	docker image pull $(BUILD_IMAGE):$(GIT_SHA)

# --------------------
# Promote Image
# --------------------
build-image-promote:
	docker image tag $(BUILD_IMAGE):$(GIT_SHA) $(BUILD_IMAGE):$(BUILD_TAG)
	docker image push $(BUILD_IMAGE):$(BUILD_TAG)

# --------------------
# Docker Compose commands
# --------------------
down:
	docker compose down --remove-orphans --volumes

up: down
	docker compose up --detach

# --------------------
# Deploy script
# --------------------
deploy:
	export AWS_ACCOUNT_ID=$(AWS_ACCOUNT_ID); \
	export AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION); \
	export AWS_ECR_DOMAIN=$(AWS_ECR_DOMAIN); \
	./deploy.sh

# --------------------
# Run locally
# --------------------
start:
	npm start
