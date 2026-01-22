{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.defaultPkgs;
in
{
  options.program.defaultPkgs = mkEnableOption "Install default packages";

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
      hyprpicker
      lazygit
      lolcat
      nix-output-monitor
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
      # Entertainment
      prismlauncher
      # Productivity
      obsidian
      # Communication
      nheko
      localsend
      # System
      blueman
      nautilus
      pwvucontrol
    ];
  };
}
