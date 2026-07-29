{ config, pkgs, ... }:
{
  program = {
    btop.enable = true;
    cava.enable = true;
    fcitx5.enable = true;
    floorp.enable = true;
    foliate.enable = true;
    fortune.enable = true;
    git.enable = true;
    neovim.enable = true;
    pass.enable = true;
    gpg.enable = true;
    mpd.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    iwgtk
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
    hypridle.enable = true;
    hyprlock.enable = true;
    syncthing.enable = true;
  };
  theme = {
    wallpaper = {
      awww.enable = true;
      waypaper = {
        enable = true;
        settings = {
          Settings = {
            use_xdg_state = true;
            folder = "${config.xdg.userDirs.pictures}/Wallpapers";
            fill = "Fill";
            sort = "name";
            backend = "awww";
            color = "#ffffff";
            subfolders = true;
            post_command = "matugen image $wallpaper --source-color-index 1";
          };
        };
      };
    };
  };
  desktop = {
    astal.enable = true;
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
    ./overrides/fcitx.nix
    ./overrides/scripts.nix
  ];
}
