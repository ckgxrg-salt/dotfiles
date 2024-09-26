{
  fetchFromGitLab,
  clangStdenv,
  pkgs,
  lib,
  ...
}:
# Desktop Frameworks: Logind Interface
clangStdenv.mkDerivation {
  pname = "dfl-login1";
  version = "69113e3e";

  nativeBuildInputs = with pkgs; [
    pkg-config
    qt5.wrapQtAppsHook
    meson
    ninja
    qt5.qttools
  ];
  buildInputs = with pkgs; [
    qt5.qtbase
    systemd
  ];

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "login1";
    rev = "07a069daf1bf8af58cea220271146e21bea34321";
    hash = "sha256-7URHVc0082LuzteSXAK1nE7vcArrsxaHG1LCV/RvTm4=";
  };
  mesonBuildType = "release";
  mesonFlags = [
    "-Duse_qt_version=qt6"
  ];

  meta = with lib; {
    description = "DFL Login1 class implements a part of the systemd logind dbus protocol.";
    longDescription = ''DFL Login1 class implements a part of the systemd logind dbus protocol.'';
    homepage = "https://gitlab.com/desktop-frameworks/login1";
    license = licenses.gpl3Plus;
  };
}
