{
  config,
  pkgs,
  ckgs,
  ...
}:
# Vistath HM entrypoint
{
  home.stateVersion = "24.11";
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";
  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;
  apps = {
    btop = true;
    cava = true;
    defaultPkgs = true;
    fcitx5.enable = true;
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
    wego
    krita
    rnote
    kana
    foliate
    komikku
    wiliwili
    freetube
    nheko
    jellyfin-media-player
    moonlight-qt
  ];
  daemons = {
    astal = {
      enable = true;
      autoreload = true;
    };
    cliphist = true;
    nm-applet = true;
    udiskie = true;
    wvkbd-vistath = true;
    polkit-gnome-agent = true;
    gammastep = true;
    hypridle = true;
    hyprlock = true;
    mako = true;
  };
  development = {
    neovim.enable = true;
    neovide = true;
  };
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.vimix-icon-theme;
      dark = "Vimix-black-dark";
    };
  };
  theme = {
    wallpaper = {
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
        theme = "tokyo_night_storm";
      };
      settings = {
        window = {
          opacity = 1.0;
          blur = true;
          decorations_theme_variant = "Dark";
          padding = {
            x = 18;
            y = 18;
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
        $env.LS_COLORS = (vivid generate tokyonight-storm | str trim)
      '';
    };
    starship = true;
  };

  imports = [
    ./overrides/hyprland.nix
  ];
}
