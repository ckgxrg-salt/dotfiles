{ pkgs, ckgs, ... }:
# Define theme names and pkgs here
{
  ckgxrg.themes = {
    enable = true;
    withFlatpak = true;

    gtk = {
      name = "Everforest-Dark-BL";
      pkg = pkgs.everforest-gtk-theme;
    };

    qt = {
      name = "Otto";
      pkg = ckgs.otto-kvantum;
    };

    cursor = {
      name = "GoogleDot-Black";
      size = 24;
      pkg = ckgs.googledot-cursor;
    };

    icon = {
      name = "Qogir-dark";
      pkg = pkgs.qogir-icon-theme;
    };

    sound = {
      enable = true;
      libcanberra = pkgs.libcanberra-gtk3;
      theme = "ocean";
      package = pkgs.kdePackages.ocean-sound-theme;
    };

    font = {
      name = "Maple Mono";
      size = 14;
    };
  };
}
