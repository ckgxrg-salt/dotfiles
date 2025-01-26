{
  fetchFromGitHub,
  stdenvNoCC,
  jdupes,
  gtk-engine-murrine,
}:
# The Otis GTK theme
stdenvNoCC.mkDerivation {
  pname = "otis-gtk-theme";
  version = "3bcf68e";

  dontBuild = true;
  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "otis";
    rev = "a3163513449d54511b35be7850bcc1c08b20eb4a";
    hash = "sha256-MUVCxfnMm8zTFJIxfGS9CxI4reanqpw1pbPrXeiJPYE=";
  };

  nativeBuildInputs = [ jdupes ];
  propagatedUserEnvPkgs = [ gtk-engine-murrine ];
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
