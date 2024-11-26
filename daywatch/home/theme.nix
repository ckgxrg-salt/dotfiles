{ pkgs, ckgs, ... }:
# Define theme names and pkgs here
{
  ckgxrg.themes = {
    enable = true;

    gtk = {
      name = "Everforest-Dark-BL";
      pkg = pkgs.everforest-gtk-theme;
    };

    qt = {
      name = "catppuccin-macchiato-lavender";
      pkg = pkgs.catppuccin-kvantum.override {
        accent = "lavender";
        variant = "macchiato";
      };
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
      name = "Maple UI";
      size = 16;
    };
  };
}
