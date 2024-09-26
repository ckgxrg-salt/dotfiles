{
  fetchFromGitLab,
  clangStdenv,
  pkgs,
  lib,
  ...
}:
# Desktop Frameworks: IPC
clangStdenv.mkDerivation {
  pname = "dfl-ipc";
  version = "4bdf90c0";

  nativeBuildInputs = with pkgs; [
    pkg-config
    qt6.wrapQtAppsHook
    meson
    ninja
    qt6.qttools
  ];
  buildInputs = with pkgs; [
    qt6.qtbase
  ];

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "ipc";
    rev = "4bdf90c0a84fddca14f1058a84f2811eaa83ba0f";
    hash = "sha256-MnS/ZswctYl2FennsG1IxZ6s4N/i/LcJGHRuyXqJIM8=";
  };
  mesonBuildType = "release";
  mesonFlags = [
    "-Duse_qt_version=qt6"
  ];

  meta = with lib; {
    description = "A very simple set of IPC classes for inter-process communication.";
    longDescription = ''
      Two very simple classes for IPC, especially between two instances of the same application. 
      These classes are used in DFL::Application.
    '';
    homepage = "https://gitlab.com/desktop-frameworks/ipc";
    license = licenses.gpl3Plus;
  };
}
