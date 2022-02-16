#!/usr/bin/env bash

set -euo pipefail

banner() {
    if [[ "${2:-}" != "first" && "${2:-}" != "last" ]]; then echo; fi
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | sed 's/ /═/g'
    printf \
        '%*s' \
        "$(( ( ${COLUMNS:-$(tput cols)} - ${#1} ) / 2))" \
        ''
    echo "$1"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | sed 's/ /═/g'
    if [[ "${2:-}" != "last" && "${2:-}" != "error" ]]; then echo; fi
}

failure() {
    if [[ $? -ne 0 ]]; then
        banner "Failure" error
    fi
}

trap failure EXIT

banner "Versions" first
rustc --version
cargo --version
rustfmt --version
rustdoc --version
cargo clippy -- --version
nixpkgs-fmt --version 2>&1 | head -n1 || true

banner "Linting"
./bin/column-check.sh
nixpkgs-fmt --check .
cargo fmt -- --check
cargo clippy -- -D warnings

banner "Testing"
cargo test

banner "Success" last
