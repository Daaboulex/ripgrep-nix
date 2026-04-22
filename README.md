# ripgrep (Nix)

[![CI](https://github.com/Daaboulex/ripgrep-nix/actions/workflows/ci.yml/badge.svg)](https://github.com/Daaboulex/ripgrep-nix/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/Daaboulex/ripgrep-nix)](./LICENSE)
[![NixOS](https://img.shields.io/badge/NixOS-unstable-78C0E8?logo=nixos&logoColor=white)](https://nixos.org)
[![Last commit](https://img.shields.io/github/last-commit/Daaboulex/ripgrep-nix)](https://github.com/Daaboulex/ripgrep-nix/commits)
[![Stars](https://img.shields.io/github/stars/Daaboulex/ripgrep-nix?style=flat)](https://github.com/Daaboulex/ripgrep-nix/stargazers)
[![Issues](https://img.shields.io/github/issues/Daaboulex/ripgrep-nix)](https://github.com/Daaboulex/ripgrep-nix/issues)

Nix flake packaging for [ripgrep](https://github.com/BurntSushi/ripgrep) by [Andrew Gallant (BurntSushi)](https://github.com/BurntSushi) — a fast line-oriented search tool that recursively searches directories for a regex pattern.

![Rust](https://img.shields.io/badge/Rust-2021-blue)
![License](https://img.shields.io/badge/License-Unlicense%20%2F%20MIT-green)
![Version 15.1.0](https://img.shields.io/badge/Version-15.1.0-orange)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-yellow)

## Upstream

This is a **Nix packaging wrapper** — not the original project. All credit for ripgrep goes to:

- **Author**: [Andrew Gallant (BurntSushi)](https://github.com/BurntSushi)
- **Repository**: [github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- **License**: [Unlicense / MIT](https://github.com/BurntSushi/ripgrep/blob/master/UNLICENSE) (dual-licensed)

## What Is This?

A Nix flake that builds [ripgrep](https://github.com/BurntSushi/ripgrep) from source with Level C security.

> **Note:** `nixpkgs` already ships `pkgs.ripgrep` at the same upstream version with PCRE2 enabled. This repo exists as the **exemplar / reference template** for the _Daaboulex Nix Packaging Standard v1_ — not because nixpkgs is insufficient. If you want ripgrep in a NixOS config and you are not maintaining a satellite flake that tracks this standard, prefer `pkgs.ripgrep` from nixpkgs. Use this flake when you want the full CI + update-contract + stale-branch-cleanup workflow as a starting point for packaging something that **is not** in nixpkgs.

Security-focused build provenance:

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

This Nix packaging flake is provided as-is and carries no additional license terms.

The upstream [ripgrep](https://github.com/BurntSushi/ripgrep) project by [Andrew Gallant](https://github.com/BurntSushi) is dual-licensed under the **Unlicense** and the **MIT License**. See the [upstream UNLICENSE](https://github.com/BurntSushi/ripgrep/blob/master/UNLICENSE) and [upstream LICENSE-MIT](https://github.com/BurntSushi/ripgrep/blob/master/LICENSE-MIT) files for full terms.
