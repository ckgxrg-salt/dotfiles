{ pkgs, ... }:
# Home-manager configuration for Cshelipix
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./desktop/ags
    ./package.nix
    ./theme.nix
    ./modes.nix
    ../../modules/terminal/zsh.nix
    ../../modules/nixvim
    ../../modules/terminal/alacritty.nix
    ../../modules/dev/langs.nix
    ../../modules/utils
  ];

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
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
