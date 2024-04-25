{ pkgs, config, ... }:
{
  # Enable Flatpak
  # services.flatpak.enable = true;

  # Nix configuration
  nix = {
      #Tuna mirror for Nix channels
      settings = {
            substituters = [
                  "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
                  "https://hyprland.cachix.org"
            ];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
            #Enable flakes
            experimental-features = [ "nix-command" "flakes" ];
      };
      #Automatic garbage collection
      gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
      };
  };

  # Allow unfree and insecure packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Security
    pkgs.sddm-chili-theme
    openssl
    kdePackages.polkit-kde-agent-1

    # CLI Utils
    direnv

    # Libs
    jdk21
    kdePackages.qtbase
    kdePackages.qttools
    kdePackages.qtwayland
    kdePackages.qtwebengine
    kdePackages.qtquick3d
    kdePackages.qt5compat
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
  ];

  # Placeholders
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
}
