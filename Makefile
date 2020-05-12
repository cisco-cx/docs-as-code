.DEFAULT_GOAL := help

SOURCE_DIRS = $(shell find * -maxdepth 0 -type d | grep -v -E '(.git|common|dist)')
export REPO_DIR := $(PWD)

all: dist  ## Alias to `make dist`, which builds all docs

build:  ## Build all doc directories
	@for i in $(SOURCE_DIRS); do \
	  echo "#### Building $$i"; \
	  cd $$i && make all && cd ..; \
	done

clean:  ## Clean all doc directories
	@for i in $(SOURCE_DIRS); do \
	  echo "#### Cleaning $$i"; \
	  make -C $$i clean; \
	done
	rm -rf dist

.PHONY: dist
dist: build ## Build all doc pdfs and copy them to ./dist directory
	mkdir -p dist
	find $(SOURCE_DIRS) -type f -name '*.pdf' | xargs -n 1 -I {} cp {} dist

help:  ## Print list of Makefile targets
	@# Taken from https://github.com/spf13/hugo/blob/master/Makefile
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  cut -d ":" -f1- | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
