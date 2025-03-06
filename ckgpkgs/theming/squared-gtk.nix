{
  fetchFromGitHub,
  stdenvNoCC,
  jdupes,
}:
# Squared GTK theme
stdenvNoCC.mkDerivation {
  pname = "squared-gtk-theme";
  version = "a4c5735";

  dontBuild = true;
  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Squared";
    rev = "a4c5735d0da8817e2bf5450e03f83d9d5d82c5e9";
    hash = "sha256-47p3EZQPXlfwlwkdSdpvtnmFzr4pZ83VgSZ6u2ZYwzI=";
  };

  nativeBuildInputs = [ jdupes ];
  installPhase = ''
    mkdir -p $out/share/themes/Squared
    mv * $out/share/themes/Squared

    rm -r $out/share/themes/Squared/Art
    rm -r $out/share/themes/Squared/LICENSE
    rm -r $out/share/themes/Squared/README.md
    rm -r $out/share/themes/Squared/{package.json,package-lock.json,Gulpfile.js}
    rm -r $out/share/themes/Squared/src
    rm -r $out/share/themes/Squared/cinnamon/*.scss
    rm -r $out/share/themes/Squared/gnome-shell/{extensions,*.scss}
    rm -r $out/share/themes/Squared/xfwm4/{assets,render_assets.fish}

    jdupes --quiet --link-soft --recurse $out/share
  '';
}
