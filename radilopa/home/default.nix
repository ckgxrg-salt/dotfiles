{ ... }:
# Home-manager entrypoint
{
  # Include home generals
  imports = [
    # Desktop environment
    ./desktop/hyprland.nix
    ./desktop/accessories
    ./desktop/xdg.nix
    ./desktop/env.nix

    # Terminal environment
    ./terminal
    ./terminal/starship.nix
    ../../generals/terminal/accessories.nix
    ../../generals/terminal/bash.nix

    # Applications
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ../../generals/apps/pass.nix
    ../../generals/gaming/opencomposite.nix

    # Other
    ./package.nix
    ./theme.nix
    ../../generals/utils
  ];

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
