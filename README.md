# Nix + Rust binary crate template

## Overview

A [`cookiecutter`](https://cookiecutter.readthedocs.io/) template for starting
a binary Rust project using Nix tooling. Note that after generating the template
project, the `cargoSha256` in `default.nix` will need to be updated by
attempting a build and, once it fails, copying the new hash back into the file.
The `README.md` will also need manual intervention.

## Testing

Run `cookiecutter --no-input .` from the root of this repository to generate an
example project, which can then be tested to see if it works as expected.
I should probably add this to CI somehow at some point. The `cargoSha256` in the
template should be the one required by the generated project.

## License

This project is licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)

* MIT license ([LICENSE-MIT](LICENSE-MIT) or
  <http://opensource.org/licenses/MIT>)

at your option.
