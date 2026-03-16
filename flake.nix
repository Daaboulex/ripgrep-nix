{
  description = "Nix flake for ripgrep — fast recursive grep replacement";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { localSystem.system = system; };
      in
      {
        packages.default = pkgs.callPackage ./package.nix { };
      }
    )
    // {
      overlays.default = final: prev: {
        ripgrep-nix = self.packages.${final.system}.default;
      };
    };
}
