# nixpkgs-ci.nix

{ supportedSystems ? ["x86_64-linux"], supportedCompilers ? ["ghc784" "ghc7103" "ghc801"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let
  genAttrs = pkgs.lib.genAttrs;

  genAgdaJobs = system: compiler:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" compiler] pkgs;
    in rec {
      Agda = haskellPackages.callPackage <agdaSrc/default.nix> {};
    };

in
  genAttrs supportedCompilers (compiler:
    genAttrs supportedSystems (system:
      genAgdaJobs system compiler))
