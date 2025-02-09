{
  stdenvNoCC,
  wrapGAppsHook,
  gobject-introspection,
  inputs,
}:
# Bundle the project
stdenvNoCC.mkDerivation rec {
  name = "ags-shell";
  version = "-1";

  src = ./ags-src;

  nativeBuildInputs = [
    inputs.ags.packages."x86_64".default
    wrapGAppsHook
    gobject-introspection
  ];

  buildInputs = with inputs.astal.packages."x86_64"; [
    astal3
    io
  ];

  installPhase = ''
    mkdit -p $out/bin
    ags bundle app.ts $out/bin/${name};
  '';
}
