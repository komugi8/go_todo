.PHONY: help build build-local up down logs ps test
.DEFOULT_GOAL := help

DOCKER_TAG := latest
build: ## Build docker image to deploy
	docker build -t komugi8/gotodo:$(DOCKER_TAG) \
		--target deploy ./

build-local: ## Build docker image to local
	docker compose build --no-cache

up: ## Start docker-compose
	docker compose up -d

down: ## Stop docker-compose
	docker compose down

logs: ## Show logs
	docker compose logs -f

ps: ## Show docker-compose status
	docker compose ps

test: ## Run test
	go test -race -shuffle=on ./...

help: ## Show help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
