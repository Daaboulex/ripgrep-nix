{
  lib,
  rustPlatform,
  fetchFromGitHub,
  asciidoctor,
  installShellFiles,
}:

let
  version = "15.1.0";
in
rustPlatform.buildRustPackage {
  pname = "ripgrep";
  inherit version;

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = version;
    hash = "sha256-0gjwYMUlXYnmIWQS1SVzF1yQw1lpveRLw5qp049lc3I=";
  };

  cargoHash = "sha256-ry3pLuYNwX776Dpj9IE2+uc7eEa5+sQvdNNeG1eJecs=";

  nativeBuildInputs = [
    asciidoctor
    installShellFiles
  ];

  postInstall = ''
    installManPage $releaseDir/build/ripgrep-*/out/rg.1
    installShellCompletion $releaseDir/build/ripgrep-*/out/rg.{bash,fish}
    installShellCompletion --zsh $releaseDir/build/ripgrep-*/out/_rg
  '';

  meta = with lib; {
    description = "Fast line-oriented search tool (grep replacement)";
    homepage = "https://github.com/BurntSushi/ripgrep";
    changelog = "https://github.com/BurntSushi/ripgrep/blob/${version}/CHANGELOG.md";
    license = with licenses; [
      unlicense
      mit
    ];
    mainProgram = "rg";
  };
}
