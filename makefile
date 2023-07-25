.DEFAULT_GOAL := help

.PHONY: help docker

help:
	@# 20s is the width of the first column
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

download-images: ## downloads the kwil and math images
	@docker pull kwildb/kwil:latest
	@docker pull kwildb/extension-math:multi-arch

run: ## runs the kwil and math containers
	@docker compose up -d

delete: ## deletes the kwil and math containers
	@docker compose down

stop: ## stops the kwil and math containers
	@docker compose stop

download-and-run: download-images run ## downloads the kwil and math images and runs the containers
