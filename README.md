# Nix + Rust Quickstart

## Overview

A [`cookiecutter`](https://cookiecutter.readthedocs.io/) template for starting
a Rust project using Nix tooling.


Valid options for `crate_type` are:

* `bin`
* `lib`

For both of these options, the generated `README.md` will need manual editing
and `flake.nix` will need its `cargoSha256` updated.

## Testing

Run `./bin/ci.sh` and `nix flake check [--print-build-logs]` to ensure things
build correctly.

## License

This project is licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)

* MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
