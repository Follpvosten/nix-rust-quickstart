{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    fenix = {
      # https://github.com/nix-community/fenix/issues/70
      url = "github:nix-community/fenix?rev=a372f826fbc2148fe6fac619c2ff93fd89e9896b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , flake-compat
    , fenix
    ,
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      rust = fenix.packages.${system};
      cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
    in
    {
      defaultPackage = (pkgs.makeRustPlatform {
        inherit (rust.stable) cargo rustc;
      }).buildRustPackage {
        pname = cargoToml.package.name;
        version = cargoToml.package.version;

        cargoSha256 = pkgs.lib.fakeSha256;

        src = builtins.filterSource
          # Exclude `target` because it's huge
          (path: type: !(type == "directory" && baseNameOf path == "target"))
          ./.;

        # This is disabled so CI can be impure and not break Nix builds
        doCheck = false;
      };

      devShell = self.defaultPackage.${system}.overrideAttrs (old: {
        # Rust Analyzer needs to be able to find the path to default crate
        # sources, and it can read this environment variable to do so
        RUST_SRC_PATH = "${rust.stable.rust-src}/lib/rustlib/src/rust/library";

        nativeBuildInputs = with pkgs; (old.nativeBuildInputs or [ ]) ++ [
          cargo-outdated
          rust.stable.clippy
          rust.stable.rust-src
          rust.latest.rustfmt

          nixpkgs-fmt

          # Needed for `./bin/ci.sh`
          ncurses
        ];
      });

      checks = {
        defaultPackage = self.defaultPackage.${system};
        devShell = self.devShell.${system};
      };
    }
    );
}
