DOCKER = docker

TAR = tar

IMAGE = debian

SUFFIX = lima

all: $(IMAGE)-rootfs-amd64.tar.gz
all: $(IMAGE)-rootfs-arm64.tar.gz

%-image-amd64.tar: %
	$(DOCKER) build --tag $*-$(SUFFIX) --platform linux/amd64 $<
	$(DOCKER) save $*-lima --output=$@

%-image-arm64.tar: %
	$(DOCKER) build --tag $*-$(SUFFIX) --platform linux/arm64 $<
	$(DOCKER) save $*-$(SUFFIX) --output=$@

$(IMAGE)-rootfs-%.tar: $(IMAGE)-image-%.tar
	$(DOCKER) load --input=$<
	ctr=`$(DOCKER) create $(IMAGE)-$(SUFFIX)`; \
	$(DOCKER) export $$ctr --output=$@ && \
	$(DOCKER) rm $$ctr >/dev/null
	-@test $(DOCKER) != "docker" || ( $(TAR) --delete .dockerenv --delete dev --delete proc --delete sys <$@ >$@.$$$$ && mv $@.$$$$ $@ )

%.tar.gz: %.tar
	gzip -9 <$< >$@

%.tar.zst: %.tar
	zstd -15 <$< >$@

.PHONY: clean
clean:
	$(RM) *-image-*.tar*
	$(RM) *-rootfs-*.tar*
