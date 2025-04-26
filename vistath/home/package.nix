{ pkgs, ckgs, ... }:
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
    wego

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
    krita
    obsidian
    rnote
    errands
    kana
    # Media
    foliate
    freetube
    jellyfin-media-player
    komikku
    wiliwili
    # Gaming
    moonlight-qt
    # Communication
    ckgs.commet-chat
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
