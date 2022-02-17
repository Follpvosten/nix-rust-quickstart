#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"

declare -A real_sha256

real_sha256=( \
    ["lib"]="\"sha256-lhuHLod82wRvIpeXVrcx1gWxg4MJT64M06aucxf4Sqc=\"" \
    ["bin"]="\"sha256-eJv5rwDjTOX/J+hziefMaFlZddZOgxSbpcL1llqy/3s=\"" \
)

for t in "${!real_sha256[@]}"; do 
    pushd "$(mktemp -d --suffix ".$(basename "$REPO_ROOT")")" || exit

    # Generate this particular configuration
    cargo-generate generate \
        --init \
        --path "$REPO_ROOT" \
        --name $t \
        --$t \
        --template-values-file "$REPO_ROOT/test-values.toml"

    # Swap the fake sha256 for one that will actually build
    sed -i "s#pkgs.lib.fakeSha256#${real_sha256[$t]}#" flake.nix

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
