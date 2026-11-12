# ripgrep (Nix)

A Nix flake that builds [ripgrep](https://github.com/BurntSushi/ripgrep) from
source. ripgrep, by [Andrew Gallant (BurntSushi)](https://github.com/BurntSushi),
is a fast line-oriented search tool that recursively searches directories for a
regex pattern.

`nixpkgs` already ships `pkgs.ripgrep` at the same upstream version with PCRE2
enabled. If you want ripgrep in a NixOS config, prefer `pkgs.ripgrep` from
nixpkgs.

The flake declares two systems, `x86_64-linux` and `aarch64-linux`. The only
test of the built program is that `rg --version` runs. Nothing here tests a
search.

## What you get

The `rg` program, its man page, and shell completions for bash, fish and zsh.

## Install

Add as a flake input:

```nix
{
  inputs.ripgrep = {
    url = "github:Daaboulex/ripgrep-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then add the overlay and install the package:

```nix
{
  nixpkgs.overlays = [ inputs.ripgrep.overlays.default ];
  environment.systemPackages = [ pkgs.ripgrep-nix ];
}
```

The overlay adds the package as `pkgs.ripgrep-nix` and leaves `pkgs.ripgrep`
as it is. Without the overlay the same package is
`inputs.ripgrep.packages.<system>.default`.

## Usage

Search recursively for a pattern:

```bash
rg "pattern" .                    # search current directory
rg -i "todo" --type rust          # case-insensitive, Rust files only
rg -l "import" src/               # list matching filenames only
rg --json "error" | jq            # structured JSON output
rg -C 3 "panic" --glob "*.rs"     # 3 lines of context, glob filter
```

Common flags:

| Flag | Description |
|------|-------------|
| `-i` | Case-insensitive |
| `-w` | Match whole words |
| `-l` | List files only |
| `-c` | Count matches |
| `-t <type>` | Filter by file type |
| `--hidden` | Include hidden files |
| `-g <glob>` | Include/exclude by glob |

## Known limits

- This build does not turn on PCRE2. The nixpkgs package does.
- No system other than the two above is declared.

## More

- [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md): building from a clone, the check,
  how the upstream version is tracked

## License

This packaging flake is [MIT](./LICENSE) licensed. Upstream [ripgrep](https://github.com/BurntSushi/ripgrep) is dual Unlicense/MIT.

The upstream [ripgrep](https://github.com/BurntSushi/ripgrep) project by [Andrew Gallant](https://github.com/BurntSushi) is dual-licensed under the **Unlicense** and the **MIT License**. See the [upstream UNLICENSE](https://github.com/BurntSushi/ripgrep/blob/master/UNLICENSE) and [upstream LICENSE-MIT](https://github.com/BurntSushi/ripgrep/blob/master/LICENSE-MIT) files for full terms.
