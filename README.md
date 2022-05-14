# Nix + Rust quickstart

A `cargo generate` template for starting a Rust project developed with Nix

---

## Usage

### Setup

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

3. Read and then run `./bin/init`

4. Develop your new Rust project with Nix!

## Licensing of generated projects

The default licensing for generated projects is `MIT OR Apache-2.0`. However,
these are just defaults. Whoever uses this template to generate a project holds
copyright over the project they generated and is free to choose how it is
licensed.
