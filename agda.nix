# nixpkgs-ci.nix

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let
  jobs = rec {
    agda = pkgs.haskellPackages.callPackage <agdaSrc/default.nix> {
      sphinx = pkgs.python34Packages.sphinx;
      sphinx_rtd_theme = pkgs.python34Packages.sphinx_rtd_theme;
      texLive = pkgs.texlive.combined.scheme-full;
    };
  };
in jobs
