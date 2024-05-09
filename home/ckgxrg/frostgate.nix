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
        lenovo-legion

        # Appearance
        darkman
        timeshift

        # Applications
        qq
        bilibili
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
