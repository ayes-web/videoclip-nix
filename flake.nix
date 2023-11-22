{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        videoclip = pkgs.callPackage ./videoclip.nix {};
      in {
        overlay = final: prev: {
          videoclip = videoclip;
        };

        packages.mpv-videoclip = videoclip;
        packages.default = videoclip;
      }
    );
}
