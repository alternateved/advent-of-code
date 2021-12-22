{
  description = "Advent Of Code 2021";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        haskellPackages = pkgs.haskellPackages;
      in {
        devShell = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            cabal-install
            ghcid
            haskell-language-server
            hlint
            hindent
            ormolu
          ];
        };
      });
}
