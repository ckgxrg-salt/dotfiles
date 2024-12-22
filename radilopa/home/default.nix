{ ... }:
# Home-manager entrypoint
{
  # Include home shared
  imports = [
    # Desktop environment
    ./desktop/hyprland.nix
    ./desktop/accessories
    ./desktop/xdg.nix
    ./desktop/env.nix

    # Terminal environment
    ./terminal
    ./terminal/starship.nix
    ../../shared/terminal/accessories.nix
    ../../shared/terminal/bash.nix

    # Applications
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./apps/btop.nix
    ../../shared/apps/pass.nix
    ../../shared/gaming/opencomposite.nix
    ../../shared/gaming/mangohud.nix

    # Other
    ./package.nix
    ./theme.nix
    ../../shared/utils
  ];

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
