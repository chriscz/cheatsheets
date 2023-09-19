REPO_ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT_DIR:=$(realpath $(shell dirname $(firstword $(MAKEFILE_LIST))))

PROJECT_NAME=$(shell basename $(ROOT_DIR))
OUTPUT_DIR=$(REPO_ROOT)/output/$(PROJECT_NAME)

TYPES=pdf html

TARGETS=$(addprefix $(OUTPUT_DIR)/index.,$(TYPES))

build: $(TARGETS)

$(OUTPUT_DIR):
	mkdir -p "$@"

$(OUTPUT_DIR)/index.%: $(OUTPUT_DIR) index.md
	pandoc index.md -f gfm  --pdf-engine=weasyprint --css=print.css -o "$@"
	

