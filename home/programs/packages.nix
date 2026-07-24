{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal Utilities
    bat
    brightnessctl
    cowsay
    dust
    fastfetch
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
    iwgtk
    nautilus
    pwvucontrol
    tzupdate
  ];
}
