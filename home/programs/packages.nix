{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal Utilities
    bat
    brightnessctl
    cowsay
    dust
    fastfetch
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
    xdg-utils

    # Entertainment
    prismlauncher
    yt-dlp
    cartridges
    umu-launcher
    freetube

    # Productivity
    obsidian

    # Communication
    commet-chat
    localsend
    vesktop

    # System
    blueman
    nautilus
    pwvucontrol
    tzupdate
  ];
}
