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
    ../../shared/terminal/carapace.nix
    ../../shared/terminal/accessories.nix
    ../../shared/terminal/bash.nix

    # Applications
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./apps/btop.nix
    ./apps/lf.nix
    ./apps/cava.nix
    ../../shared/apps/pass.nix
    ../../shared/apps/mpd.nix
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
