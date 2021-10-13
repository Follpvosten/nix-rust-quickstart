#!/usr/bin/env bash

DOCKER_BUILDKIT=1 docker build \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --tag {{cookiecutter.snake_case}} \
    .
