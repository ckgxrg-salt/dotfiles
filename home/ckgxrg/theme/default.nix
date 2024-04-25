{ config, pkgs, ... }:
{
  # GTK Look and Feel
  gtk = {
    enable = true;
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Graphite dark nord Cursors";
      package = pkgs.graphite-cursors;
    };
    font = {
      name = "Maple Mono";
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
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
    theme=Nordic-Darker
  '';

  "Kvantum/Nordic-Darker".source = "${pkgs.nordic}/share/Kvantum/Nordic-Darker";
};
}