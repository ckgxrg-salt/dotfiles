{ pkgs, ... }:
{
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
    psmisc
    gamemode
    nvitop
    maa-cli
    ripgrep

    # Desktop Utilities
    dolphin
    okular
    alacritty
    lenovo-legion

    # Games
    prismlauncher

    # Applications
    #bilibili
    tor
    tor-browser
    vscodium
    filelight
    ark
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
      "md.obsidian.Obsidian"
      "com.qq.QQ"
      "org.kde.elisa"
      "org.mozilla.Thunderbird"
      "org.kde.pix"

      "net.blockbench.Blockbench"

      "org.libreoffice.LibreOffice"
      "org.gnome.SoundRecorder"

      "com.usebottles.bottles"
    ];
  };
}
