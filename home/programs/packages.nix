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
    (prismlauncher.override {
      jdks = [
        jdk25
        jdk21
      ];
    })
    yt-dlp
    cartridges
    umu-launcher
    freetube

    # Applications
    obsidian
    actual-client
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
