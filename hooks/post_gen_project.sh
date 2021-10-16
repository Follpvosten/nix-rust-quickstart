#!/usr/bin/env bash

{% if cookiecutter.crate_type == "bin" %}
rm src/lib.rs
{% else %}
rm src/main.rs
{% endif %}

{% if cookiecutter.snake_case != "nix_rust_example" %}
# Initialize git if it hasn't been already
if [ ! -d .git ]; then
    git init
fi

tput bold
tput setaf 1
echo -n '`nix-build` will fail the first time due to a mismatching hash, this '
echo 'is expected. Simply copy the new hash into `default.nix` to fix it.'
tput setaf 3
echo "Don't forget to manually edit README.md to add a description!"
tput sgr0
echo "Also, it's recommended to make an initial commit immediately afterwards."
{% endif %}
