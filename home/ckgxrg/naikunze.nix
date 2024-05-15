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
        enableModule = true;
        deduplicate = true;
        preRemotesCommand = ''
            ${pkgs.wget}/bin/wget https://mirror.sjtu.edu.cn/flathub/flathub.gpg
            flatpak remote-modify --gpg-import=flathub.gpg flathub
            rm flathub.gpg
        '';
        remotes = {
            "flathub" = "https://mirror.sjtu.edu.cn/flathub";
        };
        packages = [
            "flathub:app/com.moonlight_stream.Moonlight//stable"
            "flathub:app/com.toolstack.Folio//stable"
        ];
  };
}
