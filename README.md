# Nix + Rust quickstart

A `cargo generate` template for starting a Rust project developed with Nix

---

## Usage

### Setup

Follow either the **Repeated use** or **One-off use** sections, then proceed to
the **Using the generated project** section.

#### Repeated use

1. Install [`cargo`][cargo] (or [`cargo-shim`][cargo-shim] if you don't want to
   install real cargo)

2. Install [`cargo-generate`][cargo-generate]

3. Add the following to your [`$CARGO_HOME/cargo-generate.toml`][cargo-home]:

    ```toml
    [favorites.nix]
    git = "https://or.computer.surgery/charles/nix-rust-quickstart"
    branch = "main"
    ```

After following those steps, you can do the following step at any time to
generate a new project:

1. Run the following command (add `--lib` if you're making a library) and follow
   the prompts

   ```sh
   cargo generate nix
   ```

[cargo]: https://doc.rust-lang.org/cargo/getting-started/installation.html
[cargo-shim]: https://or.computer.surgery/charles/cargo-shim
[cargo-generate]: https://cargo-generate.github.io/cargo-generate/installation.html
[cargo-home]: https://doc.rust-lang.org/cargo/guide/cargo-home.html

#### One-off use

1. Run the following command (add `--lib` if you're making a library)

   ```sh
   nix shell nixpkgs#cargo nixpkgs#cargo-generate -c cargo generate https://or.computer.surgery/charles/nix-rust-quickstart
   ```

### Using the generated project

1. `cd <generated-project-folder>`

2. Follow the instructions in the [**Development requirements** section in
   `CONTRIBUTING.md`](./CONTRIBUTING.md#development-requirements) if you haven't
   already

3. Read and then run [`./bin/init`](./bin/init)

4. Develop your new Rust project with Nix!

### Licensing of generated projects

Whoever uses this template to generate a project holds copyright over the
project they generated and is free to choose how it is licensed. For convenience
only, there is an option to use the licensing of `MIT OR Apache-2.0`, which is
very common.
