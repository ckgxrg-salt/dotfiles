{
  fetchFromGitHub,
  stdenv,
  pkgs,
}:
# The Otis GTK theme
stdenv.mkDerivation {
  pname = "otis-gtk-theme";
  version = "3bcf68e";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "otis";
    rev = "3bcf68e5e1516fdc427a1b5aa7ed6438f55520df";
    hash = "sha256-Ef5A7eCeUrMuzajglWGVSCBAkg+Z0X2c+yS1AjzaLB4=";
  };
  nativeBuildInputs = [ pkgs.jdupes ];
  propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
  installPhase = ''
    mkdir -p $out/share/themes/Otis
    mv * $out/share/themes/Otis

    rm -r $out/share/themes/Otis/Art
    rm -r $out/share/themes/Otis/LICENSE
    rm -r $out/share/themes/Otis/README.md
    rm -r $out/share/themes/Otis/{package.json,package-lock.json,Gulpfile.js}
    rm -r $out/share/themes/Otis/src
    rm -r $out/share/themes/Otis/cinnamon/*.scss
    rm -r $out/share/themes/Otis/gnome-shell/{extensions,*.scss}
    rm -r $out/share/themes/Otis/xfwm4/{assets,render_assets.fish}

    jdupes --quiet --link-soft --recurse $out/share
  '';
}
