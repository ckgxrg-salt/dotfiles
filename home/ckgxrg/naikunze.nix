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
        gamemode
        playerctl

        # Desktop Utilities
        xfce.thunar
        firefox
        elisa
        okular
        bottles
        alacritty
        input-remapper

        # Jvav
        eclipses.eclipse-java

        # Appearance
        darkman
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
        steam
        ventoy-full
    ];
}
