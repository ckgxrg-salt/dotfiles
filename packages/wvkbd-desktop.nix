{
  fetchFromGitHub,
  stdenv,
  pkgs,
  ...
}:
# WVKBD the Virtual Keyboard forked with desktop layout
stdenv.mkDerivation {
  pname = "wvkbd-desktop";
  version = "f1a1865";
  src = fetchFromGitHub {
    owner = "FearlessSpiff";
    repo = "wvkbd";
    rev = "f1a1865f6ba4cfc765d1abf798211462dde27e07";
    hash = "sha256-egN/vwAS/40HymvvsPX2LMCB8PmJKWTjJegRGBno2Ao=";
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
    wayland-scanner
  ];
  buildInputs = with pkgs; [
    cairo
    glib
    harfbuzz
    libxkbcommon
    pango
    wayland
  ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace "pkg-config" "$PKG_CONFIG"
  '';
  buildPhase = ''
    sed -i 's///g' layout.desktop.h
    make LAYOUT=desktop
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv wvkbd-desktop $out/bin
  '';
}
