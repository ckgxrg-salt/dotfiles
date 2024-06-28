{ pkgs, ... }: {
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
    pwvucontrol
    psmisc
    gamemode
    playerctl
    nvitop
    any-nix-shell

    # Libs
    wineWowPackages.waylandFull

    # Desktop Utilities
    dolphin
    firefox
    okular
    bottles
    alacritty
    input-remapper
    lenovo-legion

    # Games
    prismlauncher

    # Applications
    bilibili
    libreoffice
    tor
    tor-browser
    vscodium
    filelight
    ark
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
      "com.github.tchx84.Flatseal"
      "com.toolstack.Folio"
      "com.qq.QQ"
      "org.kde.elisa"
      "org.mozilla.Thunderbird"
    ];
  };
}
