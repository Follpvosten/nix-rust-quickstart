{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        name = "nix-rust-quickstart";

        nativeBuildInputs = (with pkgs; [
          cargo-generate
          file
          nixpkgs-fmt
          shellcheck
          shfmt
        ]) ++ (with pkgs.nodePackages; [
          markdownlint-cli
        ]);
      };

      checks = {
        devShellsDefault = self.devShells.${system}.default;
      };
    });
}
