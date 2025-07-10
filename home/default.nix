{ ... }:
# Entrypoint for all home-manager modules
{
  imports = [
    ./apps/btop.nix
    ./apps/calendar.nix
    ./apps/cava.nix
    ./apps/chromium.nix
    ./apps/contacts.nix
    ./apps/email.nix
    ./apps/fcitx.nix
    ./apps/floorp.nix
    ./apps/git.nix
    ./apps/gpg.nix
    ./apps/keepassxc.nix
    ./apps/kodi.nix
    ./apps/mangohud.nix
    ./apps/mpd.nix
    ./apps/opencomposite.nix
    ./apps/packages.nix
    ./apps/pass.nix
    ./apps/rofi.nix
    ./apps/yazi.nix

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
