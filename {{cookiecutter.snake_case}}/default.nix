{
  pkgs ? import <nixpkgs> {},
  inNixShell ? false,
}:

let
  # Basically the Nix version of rustup
  fenix = import (
    fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"
  ) {};

  # Load the main Cargo.toml
  cargoToml = (builtins.fromTOML (builtins.readFile ./Cargo.toml));
in

{% if cookiecutter.crate_type == "bin" -%}
pkgs.rustPlatform.buildRustPackage.override {
  # Use clang instead of GCC since the Rust ecosystem uses clang directly for
  # FFI since bindgen calls it directly instead of using $CC or such
  stdenv = pkgs.clangStdenv;
} {
{%- else -%}
pkgs.clangStdenv.mkDerivation {
{%- endif %}
  # Set Nix package data based on Cargo.toml
  pname = cargoToml.package.name;
  version = cargoToml.package.version;

{%- if cookiecutter.crate_type == "bin" %}

  # Exclude the target directory
  src = builtins.filterSource
    (path: type: !(type == "directory" && baseNameOf path == "target"))
    ./.;

  # This will need to be updated whenever the cargo dependencies change
  cargoSha256 = "sha256:0paf3mvgrsd4bg63a5gcvcc1i0cn2wr244jf8wl1bhf15lcgvpf0";
{%- endif %}

  nativeBuildInputs = with pkgs; [
    (if inNixShell then [
      # Tools that are only used for development/CI should be listed here
      docker
      (with fenix.stable; [
        clippy
        rust-analyzer
        rustfmt
      ])
    ] else [])

    # Build-time dependencies should be listed here
    (with fenix.stable; [
      cargo
      rustc
    ])
  ];
}
