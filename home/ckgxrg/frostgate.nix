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

        # Desktop Utilities
        libsForQt5.dolphin
        firefox
        elisa
        okular
        bottles
        alacritty
        input-remapper
        lenovo-legion

        # Games
        steam
        prismlauncher

        # Applications
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
            { name = "flathub"; location = "https://mirror.sjtu.edu.cn/flathub"; }
        ];
        update.auto = {
            enable = true;
            onCalendar = "daily";
        };
        packages = [
            "com.github.tchx84.Flatseal"
            "com.toolstack.Folio"
            "com.qq.QQ"
        ];
  };
}
