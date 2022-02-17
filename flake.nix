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
      devShell = pkgs.stdenv.mkDerivation {
        name = "nix-rust-quickstart";

        src = ./.;

        nativeBuildInputs = with pkgs; [
          cargo-generate
          git
          ncurses
          nixpkgs-fmt
          ripgrep
        ];
      };

      checks = {
        nixpkgs-fmt = pkgs.stdenv.mkDerivation {
          name = "nixpkgs-fmt";

          src = ./.;

          nativeBuildInputs = with pkgs; [
            nixpkgs-fmt
          ];

          dontInstall = true;

          buildPhase = ''
            nixpkgs-fmt --check .
            touch $out
          '';
        };
      };
    }
    );
}
