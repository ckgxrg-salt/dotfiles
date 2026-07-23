# Rhyslow HM entrypoint
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
    mangohud.enable = true;
    mpd.enable = true;
    vdirsyncer = {
      enable = true;
      autoUpdate = true;
    };
    vicinae.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    nvitop
    blockbench
    blender
    gimp
    libreoffice
    linux-wallpaperengine
  ];
  daemons = {
    cliphist.enable = true;
    dunst.enable = true;
    udiskie.enable = true;
    polkit-gnome-agent.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    syncthing.enable = true;
  };
  development = {
    distrobox.enable = true;
    neovim.enable = true;
  };
  theme = {
    wallpaper = {
      waypaper = {
        enable = true;
        settings = {
          Settings = {
            fill = "Fill";
            sort = "name";
            backend = "linux-wallpaperengine";
            subfolders = true;
            post_command = "matugen image $wallpaper --source-color-index 0";
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
    ./overrides/waybar.nix
    ./overrides/wlogout.nix
    ./overrides/fcitx.nix
  ];
}
