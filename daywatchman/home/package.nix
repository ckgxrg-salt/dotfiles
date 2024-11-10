{ pkgs, inputs, ... }:
{
  # Home-manager packages for Daywatchman
  home.packages = with pkgs; [
    # Terminal Utilities
    asciiquarium
    cowsay
    dust
    fastfetch
    fortune
    gamemode
    lazygit
    lolcat
    maa-cli
    inputs.nix-alien.packages.${system}.nix-alien
    powertop
    procs
    psmisc
    ripgrep
    v2raya

    # So far, Qt 6 packages require qtwayland explicitly in path. 
    qt6Packages.qtwayland
    # And dolphin need this explicitly to show icons. 
    qt6Packages.qtsvg

    # Desktop Utilities
    alacritty
    kdePackages.ark
    bottles
    kdePackages.dolphin
    gnome-decoder
    impression
    kdePackages.kdeconnect-kde
    kdePackages.okular
    pix
    seahorse
    snapshot
    system-config-printer

    # Applications
    # Productivity
    #TODO: wait until openusd fixed: blender
    blockbench
    krita
    libreoffice
    obsidian
    rnote
    # Media
    bilibili
    foliate
    freetube
    gimp
    komikku
    # Gaming
    moonlight-qt
    prismlauncher
    # Communication
    cinny-desktop
    qq
    # Web
    thunderbird
    tor-browser
  ];
}
