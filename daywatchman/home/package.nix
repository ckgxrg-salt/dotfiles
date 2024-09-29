{ pkgs, ckgs, ... }:
{
  # Home-manager packages for Daywarden
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
    alacritty
    rustdesk-flutter

    # Applications
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
    remotes = [
      {
        name = "flathub";
        location = "https://mirror.sjtu.edu.cn/flathub";
      }
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "com.qq.QQ"
      "in.cinny.Cinny"
      "info.febvre.Komikku"
      "io.freetubeapp.FreeTube"

      "com.moonlight_stream.Moonlight"
      "org.kde.elisa"
      "com.usebottles.bottles"

      "org.mozilla.Thunderbird"
      "org.kde.pix"
      "org.gnome.SoundRecorder"

      "org.blender.Blender"
      "net.blockbench.Blockbench"

      "io.github.mrvladus.List"

      "md.obsidian.Obsidian"
      "com.github.xournalpp.xournalpp"
      "org.libreoffice.LibreOffice"
      "com.github.flxzt.rnote"
      "com.github.johnfactotum.Foliate"
    ];
  };
}
