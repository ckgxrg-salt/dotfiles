{ pkgs, ... }:
# Home-manager configuration for Radilopa
{
  # Include home generals
  imports = [
    ./desktop/hyprland.nix
    ./desktop/daemons.nix
    ./terminal
    ./terminal/starship.nix
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./package.nix
    ./theme.nix
    ../../generals/terminal/accessories.nix
    ../../generals/terminal/bash.nix
    ../../generals/nixvim
    ../../generals/utils
    ../../generals/apps/pass.nix
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
  # Add fcitx5 to GTK settings
  gtk = {
    gtk2.extraConfig = "gtk-im-module=\"fcitx\"";
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };

  # Home-manager
  home = {
    username = "ckgxrg";
    homeDirectory = "/home/ckgxrg";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
