# Daywatch HM entrypoint
{
  config,
  pkgs,
  ...
}:
{
  secrets.sops = true;
  program = {
    defaultPkgs = true;
    btop.enable = true;
    calendar.enable = true;
    cava.enable = true;
    contacts.enable = true;
    email = {
      enable = true;
      autoRefresh = true;
    };
    fcitx5.enable = true;
    floorp.enable = true;
    foliate.enable = true;
    git.enable = true;
    gopass.enable = true;
    gpg.enable = true;
    mpd.enable = true;
    vdirsyncer = {
      enable = true;
      autoUpdate = true;
    };
    vicinae.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    wego
    krita
    rnote
    wiliwili
    freetube
    moonlight-qt
  ];
  daemons = {
    astal = {
      enable = true;
      autoreload = true;
    };
    cliphist.enable = true;
    dunst.enable = true;
    udiskie.enable = true;
    wvkbd.enable = true;
    polkit-gnome-agent.enable = true;
    gammastep.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    iwgtk.enable = true;
    syncthing.enable = true;
  };
  development = {
    neovim.enable = true;
  };
  stylix = {
    default = true;
    icons = {
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
    hyprland.enable = true;
    sessionVars.default = true;
    xdg.default = true;
  };
  terminal = {
    accessories.enable = true;
    alacritty.enable = true;
    bash.enable = true;
    direnv.enable = true;
    nushell.enable = true;
    starship.enable = true;
  };

  imports = [
    ./overrides/hyprland.nix
  ];
}
