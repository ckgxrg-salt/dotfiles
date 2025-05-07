{ pkgs, ... }:
{
  # Home-manager packages for Radilopa
  home.packages = with pkgs; [
    # Terminal Utilities
    bat
    cowsay
    dust
    fastfetch
    fortune
    lazygit
    lolcat
    nvitop
    procs
    psmisc
    ripgrep
    v2raya

    # Desktop Utilities
    alacritty
    kdePackages.ark
    kdePackages.okular
    pix
    seahorse

    # Applications
    # Productivity
    blockbench
    obsidian
    # Gaming
    prismlauncher
    # Communication
    localsend
    nheko
    # Web
    newsflash
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
