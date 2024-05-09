{ pkgs, config, ... }:
{
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

    # CLI Utils
    direnv
    cage

    # Libs
    jdk21
    nvidia-vaapi-driver
  ];

  # Placeholders
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
}
