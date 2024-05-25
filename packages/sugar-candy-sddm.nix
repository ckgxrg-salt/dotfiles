{ lib, fetchgit, stdenv, pkgs }:
# The Sugar Candy SDDM theme
let
  qtgraphicaleffects = pkgs.libsForQt5.qt5.qtgraphicaleffects;
  qtquickcontrols2 = pkgs.libsForQt5.qt5.qtquickcontrols2;
  qtsvg = pkgs.libsForQt5.qt5.qtsvg;
in
stdenv.mkDerivation {
  pname = "sugar-candy-sddm-theme";
  version = "2b72ef6c";
  dontWrapQtApps = true;
  src = fetchgit {
    url = "https://framagit.org/MarianArlt/sddm-sugar-candy";
    rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
    hash = "sha256-XggFVsEXLYklrfy1ElkIp9fkTw4wvXbyVkaVCZq4ZLU=";
  };
  propagatedBuildInputs = [
    qtgraphicaleffects
    qtquickcontrols2
    qtsvg
  ];
  installPhase = ''
    mkdir -p $out/share/sddm/themes/sugar-candy
    mv * $out/share/sddm/themes/sugar-candy/
  '';
  postFixup = ''
    mkdir -p $out/nix-support
    echo ${qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
    echo ${qtquickcontrols2} >> $out/nix-support/propagated-user-env-packages
    echo ${qtsvg} >> $out/nix-support/propagated-user-env-packages
  '';
}