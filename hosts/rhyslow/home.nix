{ pkgs, ... }:
{
  program = {
    btop.enable = true;
    cava.enable = true;
    distrobox.enable = true;
    fcitx5.enable = true;
    floorp.enable = true;
    foliate.enable = true;
    fortune.enable = true;
    git.enable = true;
    pass.enable = true;
    gpg.enable = true;
    mangohud.enable = true;
    mpd.enable = true;
    neovim.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    nvitop
    blockbench
    blender
    gimp
    libreoffice
    linux-wallpaperengine
    wayvr
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
  theme = {
    wallpaper = {
      waypaper = {
        enable = true;
        settings = {
          backend = "linux-wallpaperengine";
        };
      };
    };
  };
  desktop = {
    fuzzel.enable = true;
    niri.enable = true;
  };
  terminal = {
    accessories.enable = true;
    bash.enable = true;
    direnv.enable = true;
    kitty.enable = true;
    nushell.enable = true;
    starship.enable = true;
  };

  imports = [
    ./overrides/niri.nix
    ./overrides/waybar.nix
    ./overrides/wlogout.nix
    ./overrides/fcitx.nix
    ./overrides/scripts.nix
  ];
}
