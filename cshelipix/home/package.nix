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
    psmisc
    gamemode
    maa-cli

    # Desktop Utilities
    dolphin
    ark
    okular
    bottles
    alacritty
    rustdesk-flutter

    # Applications
    #bilibili
    audacity
    prismlauncher
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
      "in.cinny.Cinny"
      "info.febvre.Komikku"
      
      "com.moonlight_stream.Moonlight"
      "org.kde.elisa"
      
      "org.mozilla.Thunderbird"
      "org.kde.pix"
      
      "org.blender.Blender"
      "net.blockbench.Blockbench"
      "com.ultimaker.cura"

      "io.gitlab.idevecore.Pomodoro"
      "io.github.mrvladus.List"

      "md.obsidian.Obsidian"
      "com.github.xournalpp.xournalpp"
      "org.libreoffice.LibreOffice"
      "com.github.flxzt.rnote"
      "com.github.johnfactotum.Foliate"
    ];
  };
}
