{ pkgs, ... }: {
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
    ark
    firefox
    okular
    bottles
    alacritty
    cinnamon.pix

    # Applications
    bilibili
    audacity
    prismlauncher
    libreoffice
    tor
    tor-browser
    vscodium
    krita
    gimp
    godot_4
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
      "md.obsidian.Obsidian"
      "org.mozilla.Thunderbird"
      "io.gitlab.idevecore.Pomodoro"
      "org.blender.Blender"
      "io.github.mrvladus.List"
      "com.github.xournalpp.xournalpp"
      "org.gnome.World.Iotas"
      "com.github.johnfactotum.Foliate"
    ];
  };
}
