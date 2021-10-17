CRATE_TYPES := bin lib

.PHONY: docker_ci
docker_ci: docker_build
	docker run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-it \
		nix_rust_quickstart

.PHONY: docker_build
docker_build:
	DOCKER_BUILDKIT=1 docker build \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--tag nix_rust_quickstart \
		.

.PHONY: ci
ci: $(CRATE_TYPES)

.PHONY: $(CRATE_TYPES)
$(CRATE_TYPES):
	if [ -d nix_rust_example_$@ ]; then rm -rf nix_rust_example_$@; fi
	cookiecutter --no-input . crate_type=$@ snake_case=nix_rust_example_$@
	$(MAKE) -C nix_rust_example_$@ docker_ci
