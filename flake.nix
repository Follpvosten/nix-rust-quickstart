{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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
        nativeBuildInputs = (with pkgs; [
          cargo-generate
          file
          ncurses
          nixpkgs-fmt
          shellcheck
          shfmt
        ]) ++ (with pkgs.nodePackages; [
          markdownlint-cli
        ]);

        # HACK: <https://github.com/NixOS/nix/issues/8355#issuecomment-1551712655>
        shellHook = "unset TMPDIR";
      };

      checks = {
        devShellsDefault = self.devShells.${system}.default;
      };
    });
}
