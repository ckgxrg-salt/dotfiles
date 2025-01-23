{
  fetchFromGitHub,
  stdenv,
  pkg-config,
  wayland-scanner,
  cairo,
  glib,
  harfbuzz,
  libxkbcommon,
  pango,
  wayland,
  ...
}:
# WVKBD the Virtual Keyboard forked with desktop layout
stdenv.mkDerivation {
  pname = "wvkbd-desktop";
  version = "f1a1865";

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];
  buildInputs = [
    cairo
    glib
    harfbuzz
    libxkbcommon
    pango
    wayland
  ];

  src = fetchFromGitHub {
    owner = "FearlessSpiff";
    repo = "wvkbd";
    rev = "f1a1865f6ba4cfc765d1abf798211462dde27e07";
    hash = "sha256-egN/vwAS/40HymvvsPX2LMCB8PmJKWTjJegRGBno2Ao=";
  };

  postPatch = ''
    substituteInPlace Makefile \
      --replace "pkg-config" "$PKG_CONFIG"
  '';
  buildPhase = ''
    substituteInPlace layout.desktop.h \
      --replace "" ""
    make LAYOUT=desktop
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv wvkbd-desktop $out/bin
  '';
}
