{ ... }:
# Home-manager entrypoint
{
  # Include home shared
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
    ../../shared/terminal/direnv.nix

    # Applications
    ./apps/btop.nix
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./apps/rofi.nix
    ../../shared/apps/pass.nix
    ../../shared/apps/fcitx.nix
    ../../shared/gaming/mangohud.nix
    ../../shared/utils/git.nix
    ../../shared/utils/gpg.nix

    # Other
    ./package.nix
    ./theme.nix
  ];

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    preferXdgDirectories = true;
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
