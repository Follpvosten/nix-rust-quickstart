#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
REPO_NAME="$(basename "$REPO_ROOT")"

crate_types=(
    lib
    bin
)

for t in "${crate_types[@]}"; do
    CRATE_NAME="$REPO_NAME-$t"

    pushd "$(mktemp -d --suffix ".$CRATE_NAME")" || exit

    # Generate this particular configuration
    cargo-generate generate \
        --init \
        --path "$REPO_ROOT" \
        --name "$CRATE_NAME" \
        --define "short_description=$CRATE_NAME CI project" \
        --$t

    # Ensure the flake isn't broken
    nix flake check --print-build-logs

    # Run the actual tests
    nix develop \
        --ignore-environment \
        --keep TERM \
        --keep COLUMNS \
        --command \
        ./bin/ci.sh

    popd || exit
done
