{
  config,
  pkgs,
  ckgs,
  ...
}:
# Daywatch HM entrypoint
{
  home.stateVersion = "24.05";
  apps = {
    btop = {
      enable = true;
      colorscheme = "everforest-dark-hard";
    };
    cava = true;
    defaultPkgs = true;
    fcitx5 = {
      enable = true;
      extraPackages = [ pkgs.fcitx5-fluent ];
    };
    floorp = {
      enable = true;
    };
    git = true;
    gpg = true;
    keepassxc = true;
    mpd = true;
    pim = true;
    rofi = {
      enable = true;
      theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-2/style-4.rasi";
    };
    yazi = true;
  };
  home.packages = with pkgs; [
    impression
    snapshot
    blender
    libreoffice
    rnote
    pomodoro-gtk
    bilibili
    freetube
    gimp
    jellyfin-media-player
    moonlight-qt
    prismlauncher
  ];
  daemons = {
    astal = true;
    cliphist = true;
    nm-applet = true;
    udiskie = true;
    polkit-gnome-agent = true;
    gammastep = true;
    hypridle = true;
    hyprlock = true;
    mako = true;
  };
  development = {
    neovim.enable = true;
  };
  theme = {
    wallpaper = {
      lxwengd = {
        enable = true;
        package = ckgs.lxwengd;
        assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
      };
      swww-daemon.enable = true;
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
          };
        };
      };
    };
  };
  desktop = {
    sessionVars = {
      default = true;
    };
    hyprland = true;
    xdg = true;
  };
  terminal = {
    accessories = true;
    alacritty = {
      enable = true;
      theme = ckgs.alacritty-themes.override {
        theme = "everforest_dark";
      };
      settings = {
        window = {
          opacity = 1.0;
          blur = true;
          decorations_theme_variant = "Dark";
          padding = {
            x = 12;
            y = 12;
          };
        };
        font = {
          size = 16;
        };
      };
    };
    bash = true;
    direnv = true;
    nushell = {
      enable = true;
      theme = ckgs.nu-scripts.override {
        theme = "everforest";
      };
      settings = ''
        $env.LS_COLORS = (vivid generate catppuccin-mocha | str trim)
      '';
    };
    starship = true;
  };

  imports = [
    ./overrides/hyprland.nix
  ];
}
