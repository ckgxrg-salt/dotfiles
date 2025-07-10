{
  config,
  pkgs,
  ckgs,
  ...
}:
# Daywatch HM entrypoint
{
  home.stateVersion = "24.05";
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";
  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;
  secrets.sops = true;
  apps = {
    btop = true;
    calendar = true;
    cava = true;
    contacts = true;
    defaultPkgs = true;
    email = {
      enable = true;
      autoRefresh = true;
    };
    fcitx5.enable = true;
    floorp = {
      enable = true;
    };
    git = true;
    gpg = true;
    keepassxc = true;
    mangohud = true;
    mpd = true;
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
  ];
  daemons = {
    astal.enable = true;
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
  stylix = {
    default = true;
    iconTheme = {
      enable = true;
      package = pkgs.qogir-icon-theme;
      dark = "Qogir-Manjaro-Dark";
    };
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
    alacritty = true;
    bash = true;
    direnv = true;
    nushell = {
      enable = true;
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
