{ config, pkgs, ... }:
{
    # Home-manager packages for Cshelipix
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
        pwvucontrol
        any-nix-shell
        psmisc
        gamemode
        playerctl

        # Desktop Utilities
        dolphin
        firefox
        okular
        bottles
        alacritty
        input-remapper

        # Applications
        bilibili
        audacity
        prismlauncher
        libreoffice
        tor
        tor-browser
        vscodium
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
            "org.kde.elisa"
            "com.github.flxzt.rnote"
            "md.obsidian.Obsidian"
            "org.mozilla.Thunderbird"
            "io.gitlab.idevecore.Pomodoro"
        ];
    };
}
