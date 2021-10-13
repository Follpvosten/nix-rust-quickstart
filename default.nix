{
  pkgs ? import <nixpkgs> {},
}:

pkgs.stdenv.mkDerivation {
  name = "nix_rust_bin_quickstart";

  nativeBuildInputs = with pkgs; [
    cookiecutter
  ];
}
