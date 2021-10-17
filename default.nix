{
  pkgs ? import <nixpkgs> {},
}:

pkgs.stdenv.mkDerivation {
  name = "nix_rust_quickstart";

  nativeBuildInputs = with pkgs; [
    docker
    cookiecutter
  ];
}
