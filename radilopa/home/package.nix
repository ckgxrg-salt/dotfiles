{ pkgs, ... }:
{
  # Home-manager packages for Radilopa
  home.packages = with pkgs; [
    # Terminal Utilities
    asciiquarium
    bat
    cowsay
    dust
    fastfetch
    fortune
    lazygit
    lolcat
    maa-cli
    nvitop
    procs
    psmisc
    ripgrep
    v2raya

    # So far, Qt 6 packages require qtwayland explicitly in path.
    qt6Packages.qtwayland
    # And dolphin need this explicitly to show icons.
    qt6Packages.qtsvg

    # Desktop Utilities
    alacritty
    kdePackages.ark
    bottles
    lenovo-legion
    kdePackages.okular
    pix
    seahorse

    # Applications
    # Productivity
    blockbench
    libreoffice
    kdePackages.kdenlive
    obsidian
    vscodium
    # Gaming
    prismlauncher
    # Communication
    qq
    # Web
    thunderbird
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
