{ fetchFromGitHub, stdenvNoCC }:
# The Vivid icon theme
stdenvNoCC.mkDerivation {
  pname = "vivid-icon-theme";
  version = "5aa7ade";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "L4ki";
    repo = "Vivid-Plasma-Themes";
    rev = "51d949ecef87c1b3376b7f402d487608afeb966d";
    hash = "sha256-XD9IvvLPRS10ug6l3qQomDluqLrnnHMXjNCWZp3LweQ=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    mv Vivid\ Icons\ Themes/Vivid-Dark-Icons $out/share/icons
  '';
}
