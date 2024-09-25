{ pkgs, ... }:
# Home-manager configuration for Daywarden
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./desktop/ags
    ./desktop/daemons.nix
    ./terminal
    ./package.nix
    ./theme.nix
    ../../generals/terminal/accessories.nix
    ../../generals/terminal/bash.nix
    ../../generals/terminal/nushell.nix
    ../../generals/nixvim
    ../../generals/utils
    ../../generals/utils/qutebrowser.nix
  ];

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-nord
      fcitx5-rime
    ];
  };

  # Workaround to map shutdown to reboot
  programs.zsh.shellAliases."shutdown" = "systemctl reboot";

  # User and home directory
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";

  # Home Manager
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
