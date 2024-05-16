{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # Terminal Utilities
        neofetch
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
        nvitop

        # Libs
        wineWowPackages.waylandFull
        gamescope

        # Desktop Utilities
        xfce.thunar
        firefox
        elisa
        okular
        bottles
        alacritty
        input-remapper
        lenovo-legion
        gnome.seahorse

        # Appearance
        darkman
        timeshift

        # Applications
        qq
        bilibili
        gnome.geary
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
        filelight
        lutris
    ];
}
