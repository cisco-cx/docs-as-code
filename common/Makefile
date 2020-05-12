SHELL := /bin/bash

OUT_NAME := $(if $(OUT_NAME),$(OUT_NAME),doc-name-unset)
DIR_NAME := $(if $(DIR_NAME),$(DIR_NAME),dir-name-unset)

.DEFAULT_GOAL := help

DIST_DIR = dist
BUILD_DIR = build

WINDOWS_COMPATIBILITY_ENV_VARS = MSYS_NO_PATHCONV=1

SOURCES_MD = $(shell find * -type f -name '*.md' | grep -v -E '^(build|dist)/')

PANDOC_OPTIONS_COMMON = \
  --table-of-contents --listings --number-sections --strip-comments \
  --standalone
PANDOC_OPTIONS_EPUB = \
  --metadata title=TITLE \
  --metadata pagetitle=PAGETITLE
PANDOC_OPTIONS_HTML = \
  --template ../common/pandoc/pandoc-bootstrap-template/template.html \
  --css ../common/pandoc/pandoc-bootstrap-template/template.css \
  --self-contained
PANDOC_OPTIONS_PDF = \
  --template ../common/pandoc/templates/eisvogel.latex \
  --variable urlcolor=cyan \
  --pdf-engine xelatex

DOCKER_RUN_COMMAND = \
  $(WINDOWS_COMPATIBILITY_ENV_VARS) \
  docker run -v $(REPO_DIR):$(REPO_DIR) -w $(DIR_NAME) \
    --entrypoint "/bin/bash" --rm -it josdotso/pp:latest -c 'make _$@'

ifeq ($(NO_DOCKER),true)
	DOCKER_RUN_COMMAND = cd $(DIR_NAME) && make _$@
endif


#######################################
# Docker-Based Build Targets

all: check  ## Makes all documentation formats
	$(DOCKER_RUN_COMMAND)

html: check ## Makes HTML sources
	$(DOCKER_RUN_COMMAND)

pdf: check  ## Makes a PDF
	$(DOCKER_RUN_COMMAND)

epub: check  ## Makes an EPUB
	$(DOCKER_RUN_COMMAND)

#######################################
# Local Private Build Targets

_all: _html _pdf _epub

_html: deps $(DIST_DIR)/$(OUT_NAME).html

_pdf: $(DIST_DIR)/$(OUT_NAME).pdf

_epub: $(DIST_DIR)/$(OUT_NAME).epub

#######################################
# Core Logic

$(BUILD_DIR)/$(OUT_NAME).md: main.md $(SOURCES_MD)
	mkdir -p $(BUILD_DIR)
	pp main.md > $(BUILD_DIR)/$(OUT_NAME).md

$(DIST_DIR)/$(OUT_NAME).html: $(BUILD_DIR)/$(OUT_NAME).md
	mkdir -p $(DIST_DIR)
	pandoc \
	  --from markdown \
	  --to html5 \
	  $(PANDOC_OPTIONS_COMMON) \
	  $(PANDOC_OPTIONS_HTML) \
	  --output $(DIST_DIR)/$(OUT_NAME).html \
	  $(BUILD_DIR)/$(OUT_NAME).md

$(DIST_DIR)/$(OUT_NAME).epub: $(BUILD_DIR)/$(OUT_NAME).md
	mkdir -p $(DIST_DIR)
	pandoc \
	  --from markdown \
	  --to epub \
	  $(PANDOC_OPTIONS_COMMON) \
	  $(PANDOC_OPTIONS_EPUB) \
	  --output $(DIST_DIR)/$(OUT_NAME).epub \
	  $(BUILD_DIR)/$(OUT_NAME).md

$(DIST_DIR)/$(OUT_NAME).pdf: $(BUILD_DIR)/$(OUT_NAME).md
	mkdir -p $(DIST_DIR)
	pandoc \
	  --from markdown \
	  --to latex \
	  $(PANDOC_OPTIONS_COMMON) \
	  $(PANDOC_OPTIONS_PDF) \
	  --output $(DIST_DIR)/$(OUT_NAME).pdf \
	  $(BUILD_DIR)/$(OUT_NAME).md

check:
ifneq ($(NO_DOCKER),true)
	@if ! which docker 2>&1 > /dev/null; then \
	  echo "ERROR: Docker must be installed as a dependency"; \
	fi
endif
deps:
	@if [ ! -d ../common/pandoc/pandoc-bootstrap-template ]; then \
	  pushd ../common/pandoc && \
	    git clone https://github.com/tonyblundell/pandoc-bootstrap-template && \
	  popd; \
	fi

clean:  ## Cleans all temprary files
	rm -rf $(BUILD_DIR) $(DIST_DIR)

help:  ## Print list of Makefile targets
	@# Taken from https://github.com/spf13/hugo/blob/master/Makefile
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  cut -d ":" -f2- | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
