{
  fetchFromGitHub,
  stdenv,
  lib,
  theme ? "dark_plus",
  ...
}:
# Themes for the Alacritty terminal emulator
stdenv.mkDerivation {
  pname = "alacritty-themes";
  version = "e759daf";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "e759dafb8e2e00abb428592979ce006da7fba4a7";
    hash = "sha256-cZ+ziE+VbQFpJ+iDS7X9Q2YC1Ziu+JITzDmX79BCcRY=";
  };
  installPhase = ''
    mkdir $out
    cp themes/${theme}.toml $out/theme.toml
  '';
  meta = with lib; {
    description = "Collection of Alacritty color schemes";
    longDescription = ''
      Collection of colorschemes for easy configuration of the Alacritty terminal emulator.
    '';
    homepage = "https://github.com/alacritty/alacritty-theme";
    license = licenses.asl20;
  };
}
