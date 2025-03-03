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
    w3m

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
    localsend
    nheko
    qq
    # Web
    newsflash
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
