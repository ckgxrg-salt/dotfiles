{
  config,
  lib,
  pkgs,
  ckgs,
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

      # Desktop Utilities
      kdePackages.ark
      celluloid
      kdePackages.okular
      pix
      seahorse

      # Applications
      # Entertainment
      prismlauncher
      yt-dlp
      ckgs.cartridges
      umu-launcher
      freetube
      # Productivity
      obsidian
      # Communication
      ckgs.commet-chat
      localsend
      # Wait for upstream release, not use for now
      # vesktop
      # System
      blueman
      nautilus
      pwvucontrol
      tzupdate
    ];
  };
}
