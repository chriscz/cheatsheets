REPO_ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT_DIR:=$(realpath $(shell dirname $(firstword $(MAKEFILE_LIST))))

PROJECT_NAME=$(shell basename $(ROOT_DIR))
OUTPUT_DIR=$(REPO_ROOT)/output/$(PROJECT_NAME)

TYPES=pdf html

TARGETS=$(addprefix $(OUTPUT_DIR)/index.,$(TYPES))

# Specifying a non-existent print.css seems to make the rendering work better as links are actually blue...
ifneq ($(wildcard print.css),)
	# Exists
	PDF_OPTIONS=--css=print.css
else 
	# Does not exist
	PDF_OPTIONS=--css=print.css
endif

build: $(TARGETS)

$(OUTPUT_DIR):
	mkdir -p "$@"

$(OUTPUT_DIR)/index.%: $(OUTPUT_DIR) index.md
	pandoc index.md -f gfm  --pdf-engine=weasyprint $(PDF_OPTIONS) -o "$@"

