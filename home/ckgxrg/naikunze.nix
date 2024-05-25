{ config, pkgs, ... }:
{
    # Home-manager packages for Twirisa
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
        any-nix-shell
        nix-prefetch-github
        any-nix-shell
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

        # Applications
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
            { name = "flathub"; location = "https://mirror.sjtu.edu.cn/flathub"; }
        ];
        update.auto = {
            enable = true;
            onCalendar = "daily";
        };
        packages = [
            "com.qq.QQ"
            "com.moonlight_stream.Moonlight"
            "com.toolstack.Folio"
            "im.fluffychat.Fluffychat"
            "org.kde.kclock"
            "com.github.flxzt.rnote"
        ];
    };
}
