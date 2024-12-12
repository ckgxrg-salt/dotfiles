{ ... }:
# Home-manager entrypoint
{
  # Include home modules
  imports = [
    # Desktop environment
    ./desktop/hyprland.nix
    ./desktop/daemons.nix
    ./desktop/xdg.nix

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
