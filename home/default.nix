{ ... }:
# Entrypoint for all home-manager modules
{
  imports = [
    ./apps/btop.nix
    ./apps/cava.nix
    ./apps/fcitx.nix
    ./apps/floorp.nix
    ./apps/git.nix
    ./apps/gpg.nix
    ./apps/keepassxc.nix
    ./apps/kodi.nix
    ./apps/mpd.nix
    ./apps/opencomposite.nix
    ./apps/packages.nix
    ./apps/pim.nix
    ./apps/rofi.nix
    ./apps/yazi.nix

    ./development/nixvim

    ./daemons/daemons.nix
    ./daemons/gammastep.nix
    ./daemons/hypridle.nix
    ./daemons/hyprlock.nix
    ./daemons/mako.nix

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
    ./theme/sound-theme.nix
    ./theme/wallpaper.nix
  ];
}
