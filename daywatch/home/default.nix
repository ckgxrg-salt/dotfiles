{ pkgs, ... }:
# Home-manager configuration for Daywarden
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./desktop/ags
    ./desktop/daemons.nix
    ./desktop/xdg.nix
    ./terminal
    ./terminal/starship.nix
    ./apps/nixvim.nix
    ./apps/qutebrowser.nix
    ./apps/misc.nix
    ./apps/lf.nix
    ./package.nix
    ./theme.nix
    ../../generals/terminal/accessories.nix
    ../../generals/terminal/bash.nix
    ../../generals/nixvim
    ../../generals/utils
    ../../generals/apps/pass.nix
    ../../generals/apps/mopidy.nix
  ];

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-fluent
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
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
