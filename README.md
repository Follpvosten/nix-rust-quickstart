# Nix + Rust quickstart

A `cargo generate` template for starting a Rust project developed with Nix

---

## Usage

Refer to [`cargo-generate`][cgu]'s documentation. If you find installing `cargo`
globally undesirable, take a look at [this derivation][cargo-shim].

[cgu]: https://github.com/cargo-generate/cargo-generate#usage

[cargo-shim]: https://or.computer.surgery/charles/nur/-/tree/main/pkgs/cargo-shim

## Development

### Requirements

1. Install [Nix][nix] and enable support for [flakes][flakes]
2. Install [direnv][direnv] and [nix-direnv][nix-direnv]

[nix]: https://nixos.org/download.html
[flakes]: https://nixos.wiki/wiki/Flakes#Installing_flakes
[direnv]: https://direnv.net/docs/installation.html
[nix-direnv]: https://github.com/nix-community/nix-direnv#installation

## Licensing

### This project

This project is licensed under either of

* `Apache-2.0` ([file](LICENSE-Apache-2.0.md) or
  [online](https://opensource.org/licenses/Apache-2.0))

* `MIT` ([file](LICENSE-MIT.md) or
  [online](https://opensource.org/licenses/MIT))

at your option. The `LICENSE-AGPL-3.0-only.md` file does not apply to this
project, its inclusion is solely for generated projects (if they desire it).

### Generated projects

The default licenses for generated projects are `MIT OR Apache-2.0` for library
crates and `AGPL-3.0-only` for binary crates. However, these are just defaults.
Whoever uses this template to generate a project holds copyright over the
project they generated and is free to choose its license(s).
