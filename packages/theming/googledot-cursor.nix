{ fetchurl, stdenvNoCC }:
# The GoogleDot Cursor theme
stdenvNoCC.mkDerivation {
  pname = "googledot-cursor";
  version = "2.0.0";
  dontBuild = true;
  src = fetchurl {
    url = "https://github.com/ful1e5/Google_Cursor/releases/download/v2.0.0/GoogleDot-Black.tar.gz";
    hash = "sha256-+dhNzKv6wIYmoaSM28SvkJFUmI89ZtOQE6hE/K+9AOM=";
  };
  installPhase = ''
    mkdir -p $out/share/icons/GoogleDot-Black
    mv * $out/share/icons/GoogleDot-Black/
  '';
}
