{
  config,
  pkgs,
  ckgs,
  ...
}:
# Define theme names and pkgs here
{
  theme = {
    enable = true;

    gtk = {
      name = "Everforest-Dark-BL";
      pkg = pkgs.everforest-gtk-theme;
    };
    qt.followGTK = true;

    cursor = {
      name = "GoogleDot-Black";
      size = 24;
      pkg = ckgs.googledot-cursor;
    };

    icon = {
      name = "Qogir-Manjaro-Dark";
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
      size = 18;
    };

    wallpaper = {
      lxwengd = {
        enable = true;
        package = ckgs.lxwengd;
        assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
      };
      swww-daemon = {
        enable = true;
      };
      waypaper = {
        enable = true;
        settings = {
          Settings = {
            folder = "${config.xdg.userDirs.pictures}/Wallpapers";
            fill = "Fill";
            sort = "name";
            backend = "swww";
            color = "#ffffff";
            subfolders = true;
            monitors = "DP-1";
            swww_transition_type = "wipe";
            swww_transition_angle = 30;
          };
        };
      };
    };
  };
}
