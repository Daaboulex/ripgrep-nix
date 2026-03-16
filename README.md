# ripgrep (Nix)

Nix flake packaging for [ripgrep](https://github.com/BurntSushi/ripgrep) — a fast line-oriented search tool that recursively searches directories for a regex pattern.

![Rust](https://img.shields.io/badge/Rust-2021-blue)
![License](https://img.shields.io/badge/License-Unlicense%20%2F%20MIT-green)
![Version 15.1.0](https://img.shields.io/badge/Version-15.1.0-orange)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-yellow)

## What Is This?

A Nix flake that builds [ripgrep](https://github.com/BurntSushi/ripgrep) from source with Level C security:

- **Package integrity** — SRI hashes for source and cargo dependencies, verified on every build
- **CI security** — pinned GitHub Actions (full SHA, not tags), minimal permissions, build-gated PRs
- **Upstream trust** — daily automated version detection, hash recomputation, and test build before PR creation
- **Stale cleanup** — auto-close update PRs open >14 days, delete orphaned branches

## Installation

### NixOS (Flake)

Add as a flake input and use the overlay:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ripgrep-nix = {
      url = "github:Daaboulex/ripgrep-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ripgrep-nix, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [{
        nixpkgs.overlays = [ ripgrep-nix.overlays.default ];
        environment.systemPackages = [ pkgs.ripgrep-nix ];
      }];
    };
  };
}
```

### Direct Run

```bash
nix run github:Daaboulex/ripgrep-nix
```

### Profile Install

```bash
nix profile install github:Daaboulex/ripgrep-nix
```

## Development

```bash
git clone https://github.com/Daaboulex/ripgrep-nix
cd ripgrep-nix
nix build
./result/bin/rg --version
```

## Updates

This repository uses automated daily checks via GitHub Actions to detect new upstream releases. When a new version is found:

1. Source hash is recomputed from the release tarball
2. Cargo dependency hash is recomputed via build error extraction
3. Flake validation and test build must pass
4. A pull request is created with full verification checklist
5. Stale PRs (>14 days) are auto-closed; orphaned branches are deleted

## License

This packaging flake is provided as-is. The upstream [ripgrep](https://github.com/BurntSushi/ripgrep) project is dual-licensed under Unlicense and MIT.
