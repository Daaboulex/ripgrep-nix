{
  description = "Nix flake for ripgrep — fast recursive grep replacement";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    std = {
      url = "github:Daaboulex/nix-packaging-standard?ref=v2.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.git-hooks.follows = "git-hooks";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ inputs.std.flakeModules.base ];

      perSystem =
        { pkgs, self', ... }:
        {
          packages.default = pkgs.callPackage ./package.nix { };

          # Runtime smoke test expressed as a flake check (built by
          # nix flake check / nix-fast-build) — no bespoke CI verify step.
          checks.smoke = pkgs.runCommand "ripgrep-smoke" { } ''
            ${self'.packages.default}/bin/rg --version
            touch "$out"
          '';
        };

      flake.overlays.default = final: _prev: {
        ripgrep-nix = inputs.self.packages.${final.system}.default;
      };
    };
}
