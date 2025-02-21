{
  pkgs,
  ckgs,
  config,
  ...
}:
# Define theme names and pkgs here
{
  theme = {
    enable = true;

    gtk = {
      name = "Otis";
      pkg = ckgs.otis-gtk;
    };

    qt = {
      name = "MateriaDark";
      pkg = pkgs.materia-kde-theme;
    };

    cursor = {
      name = "Vimix-Cursors";
      size = 28;
      pkg = pkgs.vimix-cursor-theme;
    };

    icon = {
      name = "Vivid-Dark-Icons";
      pkg = ckgs.vivid-icons;
    };

    sound = {
      enable = true;
      libcanberra = pkgs.libcanberra-gtk3;
      theme = "oxygen";
      package = pkgs.kdePackages.oxygen-sounds;
    };

    font = {
      name = "Maple UI";
      size = 18;
    };

    wallpaper.lxwengd = {
      enable = true;
      package = ckgs.lxwengd;
      assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
    };
  };
}
