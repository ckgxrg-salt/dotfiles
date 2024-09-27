{ pkgs, ckgs, ... }:
# Define theme names and pkgs here
{
  ckgxrg.themes = {
    enable = true;
    guideMako = true;
    withFlatpak = true;

    gtk = {
      name = "Qogir-Dark";
      pkg = pkgs.qogir-theme.override {
        themeVariants = [ "default" ];
        colorVariants = [ "dark" ];
        tweaks = [ "round" ];
      };
    };

    qt = {
      name = "Qogir-dark";
      pkg = pkgs.qogir-kde;
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
