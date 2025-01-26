{ fetchFromGitHub, stdenvNoCC }:
# The Vivid icon theme
stdenvNoCC.mkDerivation {
  pname = "vivid-icon-theme";
  version = "5aa7ade";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "L4ki";
    repo = "Vivid-Plasma-Themes";
    rev = "6753fc4f3eea176c472e1ea1b5275e699aba0fd8";
    hash = "sha256-sq9m2m8NXiDZDfN8r0BktfAriErXDWA4MTjh6cKi0z0=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    mv Vivid\ Icons\ Themes/Vivid-Dark-Icons $out/share/icons
  '';
}
