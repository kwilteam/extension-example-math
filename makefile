.DEFAULT_GOAL := help

.PHONY: help docker

help:
	@# 20s is the width of the first column
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

download-images: ## downloads the kwil and math extensions images
	@docker pull kwildb/kwil:latest
	@docker pull kwildb/extension-math:multi-arch

run: ## runs the kwil container with the math extension
	@docker compose up -d

delete: ## deletes the kwil and math containers
	@docker compose down

stop: ## stops the kwil and math containers
	@docker compose stop

download-and-run: download-images run ## downloads the kwil and math extension images and runs the kwil and math containers

deploy-example: ## deploys the example to the kwil container
	@kwil-cli database deploy --path ./schemas/use_math.kf
