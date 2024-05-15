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
        flatpak

        # Desktop Utilities
        xfce.thunar
        firefox
        elisa
        okular
        bottles
        alacritty
        input-remapper
        gnome.seahorse

        # Programming
        eclipses.eclipse-java
        jetbrains.rust-rover

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

    # Flatpak packages
    services.flatpak = {
        enable = true;
        remotes = [
            { name = "flathub"; location = "https://mirror.sjtu.edu.cn/flathub";}
        ];
        update.auto = {
            enable = true;
            onCalendar = "daily";
        };
        packages = [
            "com.github.tchx84.Flatseal"
            "com.moonlight_stream.Moonlight"
            "com.toolstack.Folio"
        ];
  };
}