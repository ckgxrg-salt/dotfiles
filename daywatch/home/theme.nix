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
      size = 18;
    };

    wallpaper = {
      linux-wallpaperengine = {
        enable = true;
        clamping = "repeat";
        wallpapers = [
          {
            monitor = "eDP-1";
            wallpaperId = "2349470260";
            fps = 6;
            scaling = "fill";
          }
        ];
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
