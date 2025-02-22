{ pkgs, ... }:
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

    # So far, Qt 6 packages require qtwayland explicitly in path.
    qt6Packages.qtwayland

    # Desktop Utilities
    alacritty
    kdePackages.ark
    bottles
    celluloid
    impression
    kdePackages.okular
    pix
    seahorse
    snapshot

    # Applications
    # Productivity
    krita
    libreoffice
    obsidian
    rnote
    errands
    pomodoro-gtk
    # Media
    bilibili
    foliate
    freetube
    gimp
    jellyfin-media-player
    komikku
    # Gaming
    moonlight-qt
    prismlauncher
    # Communication
    localsend
    nheko
    qq
    # Web
    thunderbird
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
