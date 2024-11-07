{ pkgs, ... }:
{
  # Home-manager packages for Daywatchman
  home.packages = with pkgs; [
    # Terminal Utilities
    fastfetch
    v2raya
    procs
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
    seahorse

    # Applications
    # Productivity
    obsidian
    libreoffice
    audacity
    krita
    rnote
    #TODO: wait until openusd fixed: blender
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
    # Web
    tor-browser
    thunderbird
  ];
}
