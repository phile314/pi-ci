# nixpkgs-ci.nix

{ supportedSystems ? ["x86_64-linux"], supportedCompilers ? ["ghc7103" "ghc801"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let
  genAttrs = pkgs.lib.genAttrs;

  genAgdaJobs = system: compiler:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" compiler] pkgs;
      agda = haskellPackages.callPackage <agdaSrc/default.nix> {};
    in rec {
      # TODO why do we have to list all the jobs explicitly?
      Agda = agda.Agda;
      haddock = agda.haddock;
      tests = {
        api = agda.tests.api;
      };
    };

in
  genAttrs supportedCompilers (compiler:
    genAttrs supportedSystems (system:
      genAgdaJobs system compiler))
