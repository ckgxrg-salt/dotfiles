{ fetchgit, stdenvNoCC }:
# Everforest colorscheme for qutebrowser
stdenvNoCC.mkDerivation {
  pname = "qutebrowser-everforest";
  version = "1.0";
  dontBuild = true;

  src = fetchgit {
    url = "https://gist.github.com/04704c7860704aef5067491f5332005d.git";
    rev = "9db514efa5bfe373097cf8bb8cd0b0fa55203c2d";
    hash = "sha256-1DiqL5gQhJ7l8ympdsIVq1wql4HwiyX/0BAJwA+gVmk=";
  };

  installPhase = ''
    mkdir -p $out
    cp everforest.py $out
  '';
}
