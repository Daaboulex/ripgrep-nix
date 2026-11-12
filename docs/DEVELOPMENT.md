# Development

```bash
git clone https://github.com/Daaboulex/ripgrep-nix
cd ripgrep-nix
nix build
./result/bin/rg --version
```

The flake follows `nixos-unstable`. It is built on the
[Nix Packaging Standard](https://github.com/Daaboulex/nix-packaging-standard),
whose base module `flake.nix` imports.

## Checks

`flake.nix` declares one check of its own, `smoke`. It runs `rg --version` from
the built package, and `nix flake check` builds it.

The CI workflow is [.github/workflows/ci.yml](../.github/workflows/ci.yml).

## Upstream

| | |
|---|---|
| Project | [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) |
| License | Unlicense/MIT |
| Tracked | GitHub releases |

What is tracked is set in [.github/update.json](../.github/update.json). The
pinned version is in [package.nix](../package.nix), with two hashes: `hash` for
the source and `cargoHash` for the cargo dependencies.
