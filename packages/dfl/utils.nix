{
  fetchFromGitLab,
  clangStdenv,
  pkgs,
  lib,
  ...
}:
# Desktop Frameworks: Utils
clangStdenv.mkDerivation {
  pname = "dfl-utils";
  version = "dc97a675";

  nativeBuildInputs = with pkgs; [
    pkg-config
    qt5.wrapQtAppsHook
    meson
    ninja
    qt5.qttools
  ];
  buildInputs = with pkgs; [
    qt5.qtbase
  ];

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "utils";
    rev = "dc97a675b79b95b60b9bfb803cb300b1b38e9764";
    hash = "sha256-IxWYxQP9y51XbZAR+VOex/GYZblAWs8KmoaoFvU0rCY=";
  };
  mesonBuildType = "release";
  mesonFlags = [
    "-Duse_qt_version=qt6"
  ];

  meta = with lib; {
    description = "Some utilities for DFL";
    longDescription = ''
      The DesQ library to obtain system information and various classes and functions to be used across the DesQ project.
      This library provides single-instance Application classes for Core and Gui, advanced file-system watcher, a very simple IPC,
      functions to return XDG variables, desktop file parsing, and read various system info like battery, network, storage, cpu
      and RAM info.
    '';
    homepage = "https://gitlab.com/desktop-frameworks/utils";
    license = licenses.gpl3Plus;
  };
}
