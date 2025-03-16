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

    # So far, Qt 6 packages require qtwayland explicitly in path.
    qt6Packages.qtwayland

    # Desktop Utilities
    alacritty
    kdePackages.ark
    celluloid
    impression
    kdePackages.okular
    pix
    seahorse
    snapshot

    # Applications
    # Productivity
    krita
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
    # Media
    foliate
    freetube
    jellyfin-media-player
    komikku
    wiliwili
    # Gaming
    moonlight-qt
    # Communication
    cinny-desktop
    localsend
    qq
    # Web
    newsflash
    tor-browser
    # System
    blueberry
    nautilus
    pwvucontrol
  ];
}
