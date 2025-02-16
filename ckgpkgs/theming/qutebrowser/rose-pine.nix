{ fetchFromGitHub, stdenvNoCC }:
# Everforest colorscheme for qutebrowser
stdenvNoCC.mkDerivation {
  pname = "qutebrowser-rose-pine";
  version = "1.0";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "aalbegr";
    repo = "qutebrowser-rose-pine";
    rev = "4662474db0fa6b52985f9e9ea9c3eca16a721b5b";
    hash = "sha256-YP+Y00Ag69eO8Xx2adAEVzHYp3DuvfSfHnPh7lUXhss=";
  };

  installPhase = ''
    mkdir -p $out/rosepine
    cp *.py $out/rosepine
  '';
}
