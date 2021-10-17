.PHONY: docker_ci
docker_ci: docker_build
	docker run \
		-it \
		{{cookiecutter.snake_case}}

.PHONY: docker_build
docker_build:
	DOCKER_BUILDKIT=1 docker build \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--tag {{cookiecutter.snake_case}} \
		.
