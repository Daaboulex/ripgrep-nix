# ripgrep (Nix)

<!-- BEGIN generated:badges -->
[![NixOS unstable](https://img.shields.io/badge/NixOS-unstable-78C0E8?logo=nixos&logoColor=white)](https://nixos.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
<!-- END generated:badges -->

Nix flake packaging for [ripgrep](https://github.com/BurntSushi/ripgrep) by [Andrew Gallant (BurntSushi)](https://github.com/BurntSushi) — a fast line-oriented search tool that recursively searches directories for a regex pattern.

![Rust](https://img.shields.io/badge/Rust-2021-blue)
![License](https://img.shields.io/badge/License-Unlicense%20%2F%20MIT-green)
![Version 15.1.0](https://img.shields.io/badge/Version-15.1.0-orange)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-yellow)

<!-- BEGIN generated:upstream -->
## Upstream

| | |
|---|---|
| **Project** | [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) |
| **License** | Unlicense/MIT |
| **Tracked** | GitHub releases |
<!-- END generated:upstream -->

## What Is This?

A Nix flake that builds [ripgrep](https://github.com/BurntSushi/ripgrep) from source with Level C security.

> **Note:** `nixpkgs` already ships `pkgs.ripgrep` at the same upstream version with PCRE2 enabled. This repo exists as the **exemplar / reference template** for the _Daaboulex Nix Packaging Standard v1_ — not because nixpkgs is insufficient. If you want ripgrep in a NixOS config and you are not maintaining a satellite flake that tracks this standard, prefer `pkgs.ripgrep` from nixpkgs. Use this flake when you want the full CI + update-contract + stale-branch-cleanup workflow as a starting point for packaging something that **is not** in nixpkgs.

Security-focused build provenance:

- **Package integrity** — SRI hashes for source and cargo dependencies, verified on every build
- **CI security** — pinned GitHub Actions (full SHA, not tags), minimal permissions, build-gated PRs
- **Upstream trust** — daily automated version detection, hash recomputation, and test build before PR creation
- **Stale cleanup** — auto-close update PRs open >14 days, delete orphaned branches

<!-- BEGIN generated:installation -->
## Installation

Add as a flake input:

```nix
{
  inputs.ripgrep = {
    url = "github:Daaboulex/ripgrep-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then add the overlay:

```nix
nixpkgs.overlays = [ inputs.ripgrep.overlays.default ];
```
<!-- END generated:installation -->

## Usage

Search recursively for a pattern:

```bash
rg "pattern" .                    # search current directory
rg -i "todo" --type rust          # case-insensitive, Rust files only
rg -l "import" src/               # list matching filenames only
rg --json "error" | jq            # structured JSON output
rg -C 3 "panic" --glob "*.rs"    # 3 lines of context, glob filter
```

### Common flags

| Flag | Description |
|------|-------------|
| `-i` | Case-insensitive |
| `-w` | Match whole words |
| `-l` | List files only |
| `-c` | Count matches |
| `-t <type>` | Filter by file type |
| `--hidden` | Include hidden files |
| `-g <glob>` | Include/exclude by glob |
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

<!-- BEGIN generated:footer -->
---

*Maintained as part of the [Daaboulex](https://github.com/Daaboulex) NixOS ecosystem.*
<!-- END generated:footer -->
