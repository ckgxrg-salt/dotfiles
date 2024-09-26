{
  fetchFromGitLab,
  clangStdenv,
  pkgs,
  lib,
  ...
}:
# Desktop Frameworks: Applications
clangStdenv.mkDerivation {
  pname = "dfl-applications";
  version = "19291975";

  nativeBuildInputs = with pkgs; [
    pkg-config
    qt5.wrapQtAppsHook
    meson
    ninja
    qt5.qttools
  ];
  buildInputs = with pkgs; [
    qt5.qtbase
    (callPackage ./ipc.nix {})
  ];

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "applications";
    rev = "19291975c84a65a6abaf23ff8a7dd50239e6cde5";
    hash = "sha256-Q5xt9M4VoJpd756GiHfbto73y3OuDCjdDSdfCK0mzEk=";
  };
  mesonBuildType = "release";
  mesonFlags = [
    "-Duse_qt_version=qt6"
  ];

  meta = with lib; {
    longDescription = ''
      This library provides a thin wrapper around QApplication, QGuiApplication and QCoreApplication, to provide
      single-instance functionality. Further, with the use of DFL::IPC it also provides a smooth two-way communication
      between the first and the subsequent instances.
    '';
    homepage = "https://gitlab.com/desktop-frameworks/applications";
    license = licenses.gpl3Plus;
  };
}
