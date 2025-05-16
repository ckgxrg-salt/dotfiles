{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.defaultPkgs;
in
{
  options.apps.defaultPkgs = mkEnableOption "Install default packages";

  config = mkIf cfg {
    stylix.targets = {
      bat.enable = true;
      lazygit.enable = true;
    };

    home.packages = with pkgs; [
      # Terminal Utilities
      bat
      brightnessctl
      cowsay
      dust
      fastfetch
      fortune
      grimblast
      lazygit
      lolcat
      playerctl
      procs
      psmisc
      ripgrep
      v2raya

      # Desktop Utilities
      kdePackages.ark
      celluloid
      kdePackages.okular
      pix
      seahorse

      # Applications
      # Productivity
      obsidian
      errands
      # Communication
      nheko
      localsend
      # Web
      newsflash
      tor-browser
      # System
      blueberry
      nautilus
      pwvucontrol
    ];
  };
}
