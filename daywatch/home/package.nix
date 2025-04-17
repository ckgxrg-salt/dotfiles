{ pkgs, ... }:
{
  # Home-manager packages
  home.packages = with pkgs; [
    # Terminal Utilities
    bat
    cowsay
    dust
    fastfetch
    fortune
    lazygit
    lolcat
    powertop
    procs
    psmisc
    ripgrep
    v2raya
    w3m

    # So far, Qt 6 packages require qtwayland explicitly in path.
    qt6Packages.qtwayland

    # Desktop Utilities
    alacritty
    kdePackages.ark
    bottles
    celluloid
    impression
    kdePackages.okular
    pix
    seahorse
    snapshot

    # Applications
    # Productivity
    blender
    libreoffice
    obsidian
    rnote
    (errands.overrideAttrs {
      src = fetchFromGitHub {
        owner = "mrvladus";
        repo = "Errands";
        tag = "46.2.8";
        hash = "sha256-Gs3/DPMsoPTxH+fR7H3gPJr8ITrQDPlmw236vDnmBaA=";
      };
    })
    pomodoro-gtk
    # Media
    bilibili
    freetube
    gimp
    jellyfin-media-player
    # Gaming
    moonlight-qt
    prismlauncher
    # Communication
    kdePackages.neochat
    localsend
    nextcloud-client
    # Web
    newsflash
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
