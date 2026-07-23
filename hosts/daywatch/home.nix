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
    cava.enable = true;
    fcitx5.enable = true;
    floorp.enable = true;
    foliate.enable = true;
    fortune.enable = true;
    git.enable = true;
    pass.enable = true;
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
    krita
    rnote
    moonlight-qt
  ];
  daemons = {
    cliphist.enable = true;
    dunst.enable = true;
    udiskie.enable = true;
    wvkbd.enable = true;
    polkit-gnome-agent.enable = true;
    gammastep.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    syncthing.enable = true;
  };
  development = {
    neovim.enable = true;
  };
  theme = {
    wallpaper = {
      awww.enable = true;
      waypaper = {
        enable = true;
        settings = {
          Settings = {
            folder = "${config.xdg.userDirs.pictures}/Wallpapers";
            fill = "Fill";
            sort = "name";
            backend = "awww";
            color = "#ffffff";
            subfolders = true;
            post_command = "matugen image $wallpaper --source-color-index 0";
          };
        };
      };
    };
  };
  desktop = {
    astal.enable = true;
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
    ./overrides/fcitx.nix
  ];
}
