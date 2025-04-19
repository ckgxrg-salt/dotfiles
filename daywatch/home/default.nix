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
    ../../shared/terminal/direnv.nix

    # Applications
    ./apps/btop.nix
    ./apps/cava.nix
    ./apps/neovim.nix
    ./apps/fcitx.nix
    ./apps/floorp.nix
    ./apps/rofi.nix
    ../../shared/apps/mpd.nix
    ../../shared/apps/keepassxc.nix
    ../../shared/apps/rclone.nix
    ../../shared/apps/yazi.nix
    ../../shared/gaming/mangohud.nix
    ../../shared/utils/git.nix
    ../../shared/utils/gpg.nix

    # Other
    ./pim.nix
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
