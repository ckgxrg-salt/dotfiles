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
    localsend
    # Web
    newsflash
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
