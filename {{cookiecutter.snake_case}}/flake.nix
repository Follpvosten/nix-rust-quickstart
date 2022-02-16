{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , fenix
    ,
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      rust = fenix.packages.${system};
      cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
    in
    {
      defaultPackage = (pkgs.makeRustPlatform {
        inherit (rust.stable) cargo rustc;
      }).buildRustPackage {
        pname = cargoToml.package.name;
        version = cargoToml.package.version;

        cargoSha256 = lib.fakeSha256;

        src = builtins.filterSource
          # Exclude `target` because it's huge
          (path: type: !(type == "directory" && baseNameOf path == "target"))
          ./.;

        # You can do this manually and with more checks via `nix flake check`
        doCheck = false;
      };

      devShell = self.defaultPackage.${system}.overrideAttrs (old: {
        # Rust Analyzer needs to be able to find the path to default crate
        # sources, and it can read this environment variable to do so
        RUST_SRC_PATH = "${rust.stable.rust-src}/lib/rustlib/src/rust/library";

        nativeBuildInputs = with pkgs; (old.nativeBuildInputs or [ ]) ++ [
          pkgs.cargo-outdated
          rust.stable.clippy
          rust.stable.rust-src
          rust.latest.rustfmt

          pkgs.nixpkgs-fmt
        ];
      });

      # Package scripts matching bin/*.sh for use in the `checks` section
      packages.scripts = pkgs.stdenv.mkDerivation {
        name = "scripts";
        src = ./bin;

        # Programs the scripts need to run
        buildInputs = with pkgs; [
          ripgrep
          fd
        ];

        # Required to use `wrapProgram`
        nativeBuildInputs = with pkgs; [
          makeWrapper
        ];

        installPhase = ''
          mkdir -p $out/bin

          # Install scripts
          for f in *.sh; do
            cp $f $out/bin/''${f%%.sh}
          done

          # Fix paths
          for f in $out/bin/*; do
            wrapProgram $f \
              --prefix PATH : ${pkgs.lib.makeBinPath [
                pkgs.ripgrep
                pkgs.fd
              ]}
          done
        '';
      };

      checks = {
        column-check = self.defaultPackage.${system}.overrideAttrs (old: {
          name = "column-check";

          # That's what building this derivation is doing
          doCheck = false;

          # We're just doing CI-esque things, not trying to install anything
          dontInstall = true;

          # Skip this too since we don't need it
          dontFixup = true;

          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            self.packages.${system}.scripts
          ];

          buildPhase = ''
            # Also known as `bin/column-check.sh`; see the `packages.scripts`
            # section
            column-check
            touch $out
          '';
        });

        cargo-test = self.checks.${system}.column-check.overrideAttrs (old: {
          name = "cargo-test";

          buildPhase = ''
            cargo test -- --color=always --show-output
            touch $out
          '';
        });

        cargo-fmt = self.checks.${system}.column-check.overrideAttrs (old: {
          name = "cargo-fmt";

          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            rust.stable.rustfmt
          ];

          buildPhase = ''
            cargo fmt -- --check
            touch $out
          '';
        });

        cargo-clippy = self.checks.${system}.column-check.overrideAttrs (old: {
          name = "cargo-clippy";

          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            rust.stable.clippy
          ];

          buildPhase = ''
            cargo clippy -- -D warnings
            touch $out
          '';
        });

        nixpkgs-fmt = self.checks.${system}.column-check.overrideAttrs (old: {
          name = "nixpkgs-fmt";

          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
            pkgs.nixpkgs-fmt
          ];

          buildPhase = ''
            nixpkgs-fmt --check .
            touch $out
          '';
        });
      };
    }
    );
}
