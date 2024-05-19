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
        any-nix-shell

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
        filelight
        ark
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
            "com.toolstack.Folio"
        ];
  };
}
