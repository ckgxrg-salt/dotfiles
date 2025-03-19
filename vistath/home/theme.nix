{
  config,
  pkgs,
  ...
}:
# Define theme names and pkgs here
{
  theme = {
    enable = true;

    gtk = {
      name = "Tokyonight-Dark-Storm";
      pkg = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "default" ];
        tweakVariants = [ "storm" ];
        iconVariants = [ "Dark" ];
      };
    };

    qt = {
      name = "MateriaDark";
      pkg = pkgs.materia-kde-theme;
    };

    cursor = {
      name = "graphite-dark";
      size = 28;
      pkg = pkgs.graphite-cursors;
    };

    icon = {
      name = "Vimix-black-dark";
      pkg = pkgs.vimix-icon-theme;
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
