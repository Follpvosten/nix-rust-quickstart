#!/usr/bin/env bash

set -euo pipefail

rm -rf target
mkdir -p target

declare -A real_sha256

real_sha256=( \
    ["lib"]="\"sha256-lhuHLod82wRvIpeXVrcx1gWxg4MJT64M06aucxf4Sqc=\"" \
    ["bin"]="\"sha256-eJv5rwDjTOX/J+hziefMaFlZddZOgxSbpcL1llqy/3s=\"" \
)

pushd target || exit

for t in "${!real_sha256[@]}"; do 
    # Generate this particular configuration
    cookiecutter --no-input .. crate_type=$t snake_case=$t

    # Change directories into it
    pushd $t || exit

    # Swap the fake sha256 for one that will actually build
    sed -i "s#lib.fakeSha256#${real_sha256[$t]}#" flake.nix

    # Flakes require everything to be at least staged
    git add -A

    # Run the tests of the generated configuration
    nix flake check --print-build-logs

    popd || exit
done

popd || exit
