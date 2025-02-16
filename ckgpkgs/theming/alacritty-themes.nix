{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
  theme ? "dark_plus",
}:
# Themes for the Alacritty terminal emulator
stdenvNoCC.mkDerivation {
  pname = "alacritty-themes";
  version = "e759daf";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "69d07c3bc280add63906a1cebf6be326687bc9eb";
    hash = "sha256-O7kMi5m/fuqQZXmAMZ0hXF1ANUifK843Yfq/pEDCspE=";
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
    maintainers = with maintainers; [ ckgxrg ];
    license = licenses.asl20;
  };
}
