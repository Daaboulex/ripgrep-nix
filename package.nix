{
  lib,
  rustPlatform,
  fetchFromGitHub,
  asciidoctor,
  installShellFiles,
  pcre2,
}:

let
  version = "15.2.0";
in
rustPlatform.buildRustPackage {
  pname = "ripgrep";
  inherit version;

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = version;
    hash = "sha256-BsSIbZwB6s8i3dDTRYJ1EdVbJmiO0oxcLu6qiYlPkOI=";
  };

  cargoHash = "sha256-AqizStE9ICd6mNDZWdeXg6dHuTiY+B0TNauQQYWUa84=";

  nativeBuildInputs = [
    asciidoctor
    installShellFiles
  ];

  buildInputs = [ pcre2 ];

  buildFeatures = [ "pcre2" ];

  postInstall = ''
    installManPage $releaseDir/build/ripgrep-*/out/rg.1
    installShellCompletion $releaseDir/build/ripgrep-*/out/rg.{bash,fish}
    installShellCompletion --zsh $releaseDir/build/ripgrep-*/out/_rg
  '';

  meta = with lib; {
    description = "Fast line-oriented search tool (grep replacement)";
    homepage = "https://github.com/BurntSushi/ripgrep";
    changelog = "https://github.com/BurntSushi/ripgrep/releases/tag/${version}";
    license = with licenses; [
      unlicense
      mit
    ];
    mainProgram = "rg";
  };
}
