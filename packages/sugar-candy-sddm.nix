{
  fetchFromGitHub,
  stdenv,
  pkgs,
}:
# The Sugar Candy SDDM theme
let
  qtgraphicaleffects = pkgs.libsForQt5.qt5.qtgraphicaleffects;
  qtquickcontrols2 = pkgs.libsForQt5.qt5.qtquickcontrols2;
  qtsvg = pkgs.libsForQt5.qt5.qtsvg;
in
stdenv.mkDerivation {
  pname = "sugar-candy-sddm-theme";
  version = "a1fae51";
  dontWrapQtApps = true;
  src = fetchFromGitHub {
    owner = "Kangie";
    repo = "sddm-sugar-candy";
    rev = "a1fae5159c8f7e44f0d8de124b14bae583edb5b8";
    hash = "sha256-p2d7I0UBP63baW/q9MexYJQcqSmZ0L5rkwK3n66gmqM=";
  };
  nativeBuildInputs = [ pkgs.jdupes ];
  propagatedBuildInputs = [
    qtgraphicaleffects
    qtquickcontrols2
    qtsvg
  ];
  installPhase = ''
    mkdir -p $out/share/sddm/themes/sugar-candy
    mv * $out/share/sddm/themes/sugar-candy/
    jdupes --quiet --link-soft --recurse $out/share
  '';
  postFixup = ''
    mkdir -p $out/nix-support
    echo ${qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
    echo ${qtquickcontrols2} >> $out/nix-support/propagated-user-env-packages
    echo ${qtsvg} >> $out/nix-support/propagated-user-env-packages
  '';
}
