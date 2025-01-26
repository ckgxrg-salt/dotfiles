{ ... }:
# Home-manager entrypoint
{
  # Include home modules
  imports = [
    # Desktop environment
    ./desktop/hyprland.nix
    ./desktop/xdg.nix
    ./desktop/env.nix

    # Desktop accessories
    ./accessories

    # Terminal environment
    ./terminal
    ./terminal/starship.nix
    ../../shared/terminal/accessories.nix
    ../../shared/terminal/bash.nix

    # Applications
    ./apps/btop.nix
    ./apps/cava.nix
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./apps/rofi.nix
    ../../shared/apps/fcitx.nix
    ../../shared/apps/mpd.nix
    ../../shared/apps/pass.nix
    ../../shared/apps/yazi.nix
    ../../shared/gaming/mangohud.nix
    ../../shared/utils/git.nix
    ../../shared/utils/gpg.nix

    # Other
    ./accounts.nix
    ./package.nix
    ./theme.nix
  ];

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    preferXdgDirectories = true;
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
