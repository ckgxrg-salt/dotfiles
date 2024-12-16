{ ... }:
# Home-manager entrypoint
{
  # Include home modules
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
    ./apps/btop.nix
    ./apps/lf.nix
    ../../generals/apps/pass.nix
    ../../generals/apps/mpd.nix

    # Other
    ./accounts.nix
    ./package.nix
    ./theme.nix
    ../../generals/utils
  ];

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
