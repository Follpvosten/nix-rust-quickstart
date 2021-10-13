#!/usr/bin/env bash

docker run \
    -v "$(pwd)/src:/x/src:ro" \
    -it \
    {{cookiecutter.snake_case}} \
    "$@"
