{ pkgs, ... }:
{
  program = {
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
            use_xdg_state = true;
            fill = "Fill";
            sort = "name";
            backend = "linux-wallpaperengine";
            subfolders = true;
            post_command = "matugen image $wallpaper --source-color-index 1";
          };
        };
      };
    };
  };
  desktop = {
    fuzzel.enable = true;
    niri.enable = true;
    sessionVars.default = true;
    xdg.default = true;
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
