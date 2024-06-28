{ pkgs, ... }: {
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
    pwvucontrol
    any-nix-shell
    psmisc
    gamemode
    playerctl

    # Desktop Utilities
    xfce.thunar
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
    steam
    ventoy-full
  ];

  # Flatpak packages
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://mirror.sjtu.edu.cn/flathub";
    }];
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
    ];
  };
}
