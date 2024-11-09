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
    lazygit
    lolcat
    fortune
    psmisc
    gamemode
    maa-cli

    # So far, Qt 6 packages require qtwayland explicitly in path. 
    qt6Packages.qtwayland
    # And dolphin need this explicitly to show icons. 
    qt6Packages.qtsvg

    # Desktop Utilities
    alacritty
    system-config-printer
    kdePackages.kdeconnect-kde
    kdePackages.okular
    pix
    kdePackages.dolphin
    kdePackages.ark
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
