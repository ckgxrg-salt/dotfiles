{ pkgs, ... }:
{
  # Home-manager packages for Daywatchman
  home.packages = with pkgs; [
    # Terminal Utilities
    fastfetch
    v2raya
    procs
    btop
    dust
    cowsay
    asciiquarium
    lolcat
    fortune
    psmisc
    gamemode
    maa-cli

    # Desktop Utilities
    alacritty
    system-config-printer
    kdePackages.kdeconnect-kde
    okular
    pix
    dolphin
    ark
    snapshot
    gnome-decoder
    impression
    bottles

    # Applications
    # Productivity
    obsidian
    libreoffice
    audacity
    vscodium
    krita
    rnote
    blender
    blockbench
    # Media
    bilibili
    freetube
    foliate
    komikku
    gimp
    # Gaming
    prismlauncher
    moonlight-qt
    # Communication
    cinny-desktop
    qq
    rustdesk-flutter
    # Web
    tor-browser
    thunderbird
  ];
}
