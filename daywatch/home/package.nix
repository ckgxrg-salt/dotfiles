{ pkgs,... }:
{
  # Home-manager packages
  home.packages = with pkgs; [
    # Terminal Utilities
    bat
    cowsay
    dust
    fastfetch
    fortune
    lazygit
    lolcat
    powertop
    procs
    psmisc
    ripgrep
    v2raya

    # Desktop Utilities
    alacritty
    kdePackages.ark
    celluloid
    impression
    kdePackages.okular
    pix
    seahorse
    snapshot

    # Applications
    # Productivity
    blender
    libreoffice
    obsidian
    rnote
    errands
    pomodoro-gtk
    # Media
    bilibili
    freetube
    gimp
    jellyfin-media-player
    # Gaming
    moonlight-qt
    prismlauncher
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
}
