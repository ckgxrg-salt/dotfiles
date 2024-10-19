{ pkgs, ... }:
{
  # Home-manager packages for Daywatchman
  home.packages = with pkgs; [
    # Terminal Utilities
    fastfetch
    v2raya
    procs
    btop
    dust
    cowsay
    asciiquarium
    lolcat
    fortune
    psmisc
    gamemode
    maa-cli

    # Desktop Utilities
    alacritty
    system-config-printer
    kdeconnect

    # Applications
    audacity
    bilibili
    prismlauncher
    tor-browser
    vscodium
    gimp
    krita
    okular
    pix
    dolphin
    ark
    rustdesk-flutter
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
      # Communication
      "com.qq.QQ"
      "in.cinny.Cinny"
      "org.mozilla.Thunderbird"
      # Util
      "org.gnome.Snapshot"
      "org.gnome.SoundRecorder"
      "com.belmoussaoui.Decoder"
      "io.gitlab.adhami3310.Impression"
      "com.github.flxzt.rnote"
      # Media
      "info.febvre.Komikku"
      "io.freetubeapp.FreeTube"
      "com.github.johnfactotum.Foliate"
      # Work
      "org.blender.Blender"
      "net.blockbench.Blockbench"
      "md.obsidian.Obsidian"
      "org.libreoffice.LibreOffice"
      # Gameing
      "com.moonlight_stream.Moonlight"
      # Misc
      "com.usebottles.bottles"
    ];
  };
}
