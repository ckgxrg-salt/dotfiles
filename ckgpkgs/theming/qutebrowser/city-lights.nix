{ fetchFromGitHub, stdenvNoCC }:
# Everforest colorscheme for qutebrowser
stdenvNoCC.mkDerivation {
  pname = "qutebrowser-city-lights";
  version = "1.0";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "gicrisf";
    repo = "qute-city-lights";
    rev = "047d5306ce6ce74d17b2d3a58b9419c89a0fb238";
    hash = "sha256-khIH2oDgL9+K6Z6GxXfm3qVEA1vIOwNASULHTP6P1sw=";
  };

  installPhase = ''
    mkdir -p $out
    cp city-lights-theme.py $out
  '';
}
