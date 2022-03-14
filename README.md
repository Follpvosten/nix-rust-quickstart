# Nix + Rust quickstart

A `cargo generate` template for starting a Rust project developed with Nix

---

## Usage

### Set-up

1. Install [`cargo`][cargo] (or [`cargo-shim`][cargo-shim] if you don't want to
   install real cargo)

2. Install [`cargo-generate`][cargo-generate]

3. Add the following to your [`$CARGO_HOME/cargo-generate.toml`][cargo-home]:

    ```toml
    [favorites.nix]
    git = "https://or.computer.surgery/charles/nix-rust-quickstart"
    branch = "main"
    ```

[cargo-home]: https://doc.rust-lang.org/cargo/guide/cargo-home.html

[cargo-generate]: https://cargo-generate.github.io/cargo-generate/installation.html

[cargo]: https://doc.rust-lang.org/cargo/getting-started/installation.html

[cargo-shim]: https://or.computer.surgery/charles/cargo-shim

### Generating a project

1. Run `cargo generate nix` (add `--lib` if you're making a library) and follow
   the prompts

### Using the generated project

1. `cd <generated-project-folder>`

2. Follow the instructions in the "Development requirements" section in the
   `CONTRIBUTING.md` file in that folder if you haven't already

3. `git add -A && direnv allow`

4. Nix will complain about `cargoSha256` being out of date:

   ```text
   error: hash mismatch in fixed-output derivation '/nix/store/kd2m0pa3dq6rvr3fmxk2h1n418nkzyz0-example_project-0.1.0-vendor.tar.gz.drv':
         specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
            got:    sha256-C1f5r+Kl44YjVB60LqH1VpfVQJl7QxjDMo0QyNmtnAM=
   ```

   Fix this by copying the value after `got:` and setting it in `flake.nix` like
   so:

   ```nix
   cargoSha256 = "sha256-C1f5r+Kl44YjVB60LqH1VpfVQJl7QxjDMo0QyNmtnAM=";
   ```

5. direnv should automatically reload after detecting changes to `flake.nix`,
   but if it doesn't, run `direnv reload` to trigger it manually

6. `git add -A && git commit -m "initial commit"`

7. Develop your new Rust project with Nix!

## Development

1. Install [Nix][nix] and enable support for [flakes][flakes]
2. Install [direnv][direnv] and [nix-direnv][nix-direnv]
3. Run `./bin/ci.sh` before committing/pushing

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
