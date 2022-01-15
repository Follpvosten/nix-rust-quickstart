{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage = pkgs.stdenv.mkDerivation {
        name = "nix-rust-quickstart";

        src = ./.;

        nativeBuildInputs = with pkgs; [
          cookiecutter
          git
          ncurses
          ripgrep
        ];
      };

      devShell = self.defaultPackage.${system};
    }
  );
}
