{ pkgs, ... }:
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
      "com.usebottles.bottles"
      "io.gitlab.adhami3310.Impression"

      "org.mozilla.Thunderbird"
      "org.gnome.Snapshot"
      "org.gnome.SoundRecorder"
      "com.belmoussaoui.Decoder"

      "org.blender.Blender"
      "net.blockbench.Blockbench"

      "md.obsidian.Obsidian"
      "org.libreoffice.LibreOffice"
      "com.github.flxzt.rnote"
      "com.github.johnfactotum.Foliate"
    ];
  };
}
