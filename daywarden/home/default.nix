{ pkgs, ... }:
# Home-manager configuration for Daywarden
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./desktop/ags
    ./package.nix
    ./theme.nix
    ../../modules/terminal/accessories.nix
    ../../modules/terminal/alacritty.nix
    ../../modules/terminal/bash.nix
    ../../modules/terminal/nushell.nix
    ../../modules/nixvim
    ../../modules/utils
    ../../modules/utils/qutebrowser.nix
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
