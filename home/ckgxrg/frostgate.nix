{ config, pkgs, ... }:
{
    # Home-manager packages for Radilopa
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
        any-nix-shell

        # Libs
        wineWowPackages.waylandFull
        gamescope
        wlroots

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

        # Games
        steam
        prismlauncher

        # Applications
        qq
        bilibili
        gnome.geary
        libreoffice
        kdePackages.sweeper
        clamtk
        clamav
        tor
        tor-browser
        vscodium
        ventoy-full
        filelight
        ark
    ];
}
