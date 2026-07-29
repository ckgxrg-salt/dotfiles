{ osConfig, ... }:
{
  imports = [
    ./programs/btop.nix
    ./programs/cava.nix
    ./programs/distrobox.nix
    ./programs/fcitx.nix
    ./programs/floorp.nix
    ./programs/foliate.nix
    ./programs/fortune.nix
    ./programs/git.nix
    ./programs/pass.nix
    ./programs/gpg.nix
    ./programs/mangohud.nix
    ./programs/mpd.nix
    ./programs/neovim
    ./programs/packages.nix
    ./programs/yazi.nix

    ./daemons/daemons.nix
    ./daemons/dunst.nix
    ./daemons/hypridle.nix
    ./daemons/hyprlock.nix
    ./daemons/syncthing.nix

    ./desktop/astal.nix
    ./desktop/env.nix
    ./desktop/fuzzel.nix
    ./desktop/gtk.nix
    ./desktop/niri.nix
    ./desktop/qt.nix
    ./desktop/xdg.nix

    ./terminal/accessories.nix
    ./terminal/bash.nix
    ./terminal/direnv.nix
    ./terminal/kitty.nix
    ./terminal/nushell.nix
    ./terminal/starship.nix
    ./terminal/zellij.nix

    ./theme/cursor.nix
    ./theme/lxwengd.nix
    ./theme/matugen.nix
    ./theme/wallpaper.nix
  ];

  config = {
    home.stateVersion = osConfig.device.version;
    home.username = "ckgxrg";
    home.homeDirectory = "/home/ckgxrg";
    home.preferXdgDirectories = true;
    programs.home-manager.enable = true;
  };
}
