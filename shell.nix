{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/3c4969b9bc5b7642b2c6c583a6734eb210e5f0f8.tar.gz")
  { } }:

let
  haskellTools = with pkgs; [
    ghc
    ghcid
    cabal-install
    haskellPackages.hindent
    haskellPackages.hoogle
    haskellPackages.ormolu
    haskellPackages.haskell-language-server
  ];

  haskellDeps = with pkgs; [ ];

in pkgs.mkShell {
  buildInputs = haskellTools ++ haskellDeps;
}
