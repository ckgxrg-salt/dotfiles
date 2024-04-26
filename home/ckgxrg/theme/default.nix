{ config, pkgs, ... }:
let
  gtkTheme = "Nordic-darker";
  gtkPkg = pkgs.nordic;
  qtStyle = "Nordic-Darker";
  qtPkg = pkgs.nordic;
  cursor = "Graphite dark nord Cursors";
  customFont = "Maple Mono";
  icon = "Papirus-Dark";

in {
  # GTK Look and Feel
  gtk = {
    enable = true;
    theme = {
      name = gtkTheme;
      package = gtkPkg;
    };
    cursorTheme = {
      name = cursor;
      package = pkgs.graphite-cursors;
    };
    font = {
      name = customFont;
      size = 12;
    };
    iconTheme = {
      name = icon;
      package = pkgs.papirus-icon-theme;
    };
  };

  #Qt Style
  home.packages = with pkgs; [
    kdePackages.qtbase
    kdePackages.qttools
    kdePackages.qtwayland
    kdePackages.qtwebengine
    kdePackages.qtquick3d
    kdePackages.qt5compat
    kdePackages.qtsvg
    kdePackages.qt6gtk2
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
  ];
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
  "Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${qtStyle}
  '';

  "Kvantum/${qtStyle}".source = "${qtPkg}/share/Kvantum/${qtStyle}";
};
}