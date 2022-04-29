# make images
ORG=$(shell pwd|awk -F'/' '{print $$NF}')
IMAGES=$(shell find . -maxdepth 2 -name "Dockerfile" -type f|awk -F'/' '{print $$(NF-1)}')

.PHONY: all $(IMAGES)

all: $(IMAGES)

$(IMAGES):
	echo $@
	@docker build --tag=$(ORG)/$@ ./$@
