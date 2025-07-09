{
  config,
  pkgs,
  ckgs,
  ...
}:
# Rhyslow HM entrypoint
{
  home.stateVersion = "25.05";
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";
  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;
  secrets.sops = true;
  apps = {
    btop = true;
    calendar = true;
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
      theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-3/style-1.rasi";
    };
    yazi = true;
  };
  home.packages = with pkgs; [
    nvitop
    blockbench
    blender
    gimp
    libreoffice
    prismlauncher
  ];
  daemons = {
    cliphist = true;
    nm-applet = true;
    udiskie = true;
    polkit-gnome-agent = true;
    hypridle = true;
    hyprlock = true;
    mako = true;
    syncthing = true;
  };
  development = {
    neovim.enable = true;
  };
  stylix = {
    default = true;
    iconTheme = {
      enable = true;
      package = pkgs.dracula-icon-theme;
      dark = "Dracula";
    };
  };
  theme = {
    wallpaper = {
      lxwengd = {
        enable = true;
        package = ckgs.lxwengd;
        assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
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
        $env.LS_COLORS = (vivid generate iceberg-dark | str trim)
      '';
    };
    starship = true;
  };

  imports = [
    ./overrides/hyprland.nix
    ./overrides/waybar.nix
    ./overrides/wlogout.nix
  ];
}
