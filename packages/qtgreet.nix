{
  fetchFromGitLab,
  clangStdenv,
  pkgs,
  lib,
  ...
}:
# The Qt Greeter for Greetd
clangStdenv.mkDerivation {
  pname = "qtgreet";
  version = "69113e3e";

  nativeBuildInputs = with pkgs; [
    pkg-config
    qt6.wrapQtAppsHook
    meson
    ninja
    qt6.qttools
    wlroots
  ];
  buildInputs = with pkgs; [
    qt6.qtbase
    kdePackages.wayqt
    (callPackage ./dfl/login1.nix {})
    (callPackage ./dfl/utils.nix {})
    (callPackage ./dfl/ipc.nix {})
    (callPackage ./dfl/applications.nix {})
  ];

  src = fetchFromGitLab {
    owner = "marcusbritanicus";
    repo = "QtGreet";
    rev = "69113e3eedd3a01a2452d85effb89379835bca89";
    hash = "sha256-jzeP3iFcdW43N8QL9Y+xJDIE1o0Nv4JuR2HNmH/QV7g=";
  };
  mesonFlags = [
    "--buildtype=release"
  ];

  meta = with lib; {
    description = "Qt based greeter for greetd, to be run under wayfire or similar wlr-based compositors.";
    homepage = "https://gitlab.com/marcusbritanicus/QtGreet";
    license = licenses.gpl3Plus;
  };
}
