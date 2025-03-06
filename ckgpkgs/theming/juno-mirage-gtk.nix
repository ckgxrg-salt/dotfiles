{
  fetchFromGitHub,
  stdenvNoCC,
  jdupes,
  gtk-engine-murrine,
}:
# Juno-mirage GTK theme
stdenvNoCC.mkDerivation {
  pname = "juno-mirage-gtk-theme";
  version = "3bcf68e";

  dontBuild = true;
  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Juno";
    rev = "488014922b9186b646696bcc77ead5c4ad6e7db6";
    hash = "sha256-D3/drIxYN8wdHqEhbkZs6WXHdt92NPfjPNEGG8Le0KQ=";
  };

  nativeBuildInputs = [ jdupes ];
  propagatedUserEnvPkgs = [ gtk-engine-murrine ];
  installPhase = ''
    mkdir -p $out/share/themes/Juno-mirage
    mv * $out/share/themes/Juno-mirage

    rm -r $out/share/themes/Juno-mirage/Art
    rm -r $out/share/themes/Juno-mirage/LICENSE
    rm -r $out/share/themes/Juno-mirage/README.md
    rm -r $out/share/themes/Juno-mirage/{package.json,package-lock.json,Gulpfile.js}
    rm -r $out/share/themes/Juno-mirage/src
    rm -r $out/share/themes/Juno-mirage/cinnamon/*.scss
    rm -r $out/share/themes/Juno-mirage/gnome-shell/{extensions,*.scss}
    rm -r $out/share/themes/Juno-mirage/xfwm4/{assets,render_assets.fish}

    jdupes --quiet --link-soft --recurse $out/share
  '';
}
