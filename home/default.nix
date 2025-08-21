{ ... }:
# Entrypoint for all home-manager modules
{
  imports = [
    ./programs/btop.nix
    ./programs/calendar.nix
    ./programs/cava.nix
    ./programs/chromium.nix
    ./programs/contacts.nix
    ./programs/email.nix
    ./programs/fcitx.nix
    ./programs/floorp.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/keepassxc.nix
    ./programs/kodi.nix
    ./programs/mangohud.nix
    ./programs/mpd.nix
    ./programs/opencomposite.nix
    ./programs/packages.nix
    ./programs/pass.nix
    ./programs/rofi.nix
    ./programs/yazi.nix
    ./programs/zk.nix

    ./development/nixvim
    ./development/neovide.nix

    ./daemons/astal.nix
    ./daemons/daemons.nix
    ./daemons/gammastep.nix
    ./daemons/hypridle.nix
    ./daemons/hyprlock.nix
    ./daemons/mako.nix
    ./daemons/syncthing.nix

    ./desktop/env.nix
    ./desktop/hyprland.nix
    ./desktop/xdg.nix

    ./terminal/accessories.nix
    ./terminal/alacritty.nix
    ./terminal/bash.nix
    ./terminal/direnv.nix
    ./terminal/nushell.nix
    ./terminal/starship.nix

    ./theme/lxwengd.nix
    ./theme/stylix.nix
    ./theme/sound-theme.nix
    ./theme/wallpaper.nix

    ../secrets
  ];
}
