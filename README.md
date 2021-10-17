# Nix + Rust Quickstart

## Overview

A [`cookiecutter`](https://cookiecutter.readthedocs.io/) template for starting
a Rust project using Nix tooling.


Valid options for `crate_type` are:

* `bin`
    * `README.md` requires manual intervention post-generation
    * Note that after generating the template project, the `cargoSha256` in
      `default.nix` will need to be updated by attempting a build and, once it
      fails, copying the new hash back into the file.
* `lib`
    * `README.md` requires manual intervention post-generation

## Testing

Running `make` in the root of this repository will generate a project for each
crate type and then run their respective CI suites. The `cargoSha256` in the
template should be the one required by the generated `bin` type project.

## License

This project is licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)

* MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
