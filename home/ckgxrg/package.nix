{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # Terminal Utilities
        neofetch
        thefuck
        wget
        v2raya
        procs
        cowsay
        asciiquarium
        lolcat
        fortune
        zellij
        pavucontrol
            gradle
        nix-prefetch-github
        psmisc

        # Desktop Utilities
        kdePackages.dolphin
        firefox
        elisa
        okular
        bottles
        alacritty
        input-remapper

        # Jvav
        eclipses.eclipse-java

        # Appearance
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum
        nwg-look
        darkman
        papirus-nord
        timeshift

        # Applications
        qq
        bilibili
        audacity
        prismlauncher
        libreoffice
        kdePackages.sweeper
        clamtk
        clamav
        tor
        tor-browser
        vscodium
    ];
}
