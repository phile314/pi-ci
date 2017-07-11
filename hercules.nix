# nixpkgs-ci.nix


let
  pkgs = import <nixpkgs> {};
in
  pkgs.callPackage <hercules-src> {}
