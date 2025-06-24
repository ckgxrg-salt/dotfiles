{
  config,
  pkgs,
  ckgs,
  ...
}:
# Asedia HM entrypoint
{
  home.stateVersion = "25.05";
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";
  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;
  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    age.keyFile = "/home/ckgxrg/.config/sops/age/keys.txt";
    secrets = {
      "gmail-oauth" = { };
      "private-email" = { };
      "dav-passwd" = { };
    };
  };
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
    mpd = true;
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
    syncthing = true;
  };
  development = {
    neovim.enable = true;
  };
  stylix = {
    default = true;
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
    alacritty = true;
    bash = true;
    direnv = true;
    nushell = {
      enable = true;
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
