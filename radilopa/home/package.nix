{ pkgs, inputs, ... }:
{
  # Home-manager packages for Radilopa
  home.packages = with pkgs; [
    # Terminal Utilities
    asciiquarium
    cowsay
    fastfetch
    fortune
    gamemode
    lazygit
    lolcat
    maa-cli
    inputs.nix-alien.packages.${system}.nix-alien
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
    kdePackages.dolphin
    kdePackages.filelight
    lenovo-legion
    kdePackages.okular
    pix
    seahorse

    # Applications
    # Productivity
    blockbench
    libreoffice
    obsidian
    vscodium
    # Media
    kdePackages.elisa
    # Gaming
    prismlauncher
    # Communication
    qq
    # Web
    thunderbird
    tor-browser
  ];
}
