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
      name = "rose-pine-moon";
      pkg = pkgs.rose-pine-gtk-theme;
    };

    qt = {
      name = "MoeDark";
      pkg = ckgs.moe-kvantum-theme;
    };

    cursor = {
      name = "BreezeX-RosePine-Linux";
      size = 24;
      pkg = pkgs.rose-pine-cursor;
    };

    icon = {
      name = "rose-pine-moon";
      pkg = pkgs.rose-pine-icon-theme;
    };

    sound = {
      enable = true;
      libcanberra = pkgs.libcanberra-gtk3;
      theme = "ocean";
      package = pkgs.kdePackages.ocean-sound-theme;
    };

    font = {
      name = "Jost*";
      size = 18;
    };

    wallpaper = {
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
