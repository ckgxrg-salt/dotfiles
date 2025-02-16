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
    rev = "231623a9c66b1aa70b48f8b789fa01bab78045d9";
    hash = "sha256-mBSIrs+OPvGO0JcEYnrq27ch//r8tYSfoD4sTV3rvLE=";
  };

  postPatch = ''
    substituteInPlace Makefile \
      --replace "pkg-config" "$PKG_CONFIG"
    substituteInPlace layout.desktop.h \
      --replace "" ""
    substituteInPlace main.c \
      --replace "DEFAULT_ROUNDING" "5"
  '';

  makeFlags = [ "LAYOUT=desktop" ];
  installFlags = [ "PREFIX=$(out)" ];
}
