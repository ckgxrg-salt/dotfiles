{ pkgs, config, inputs, ... }:
{
  # Nix configuration
  nix = {
      # USTC mirror for Nix channels
      settings = {
            substituters = [
              "https://hyprland.cachix.org"
              "https://mirror.sjtu.edu.cn/nix-channels/store"
              "https://cache.nixos.org"
            ];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
            # Enable flakes
            experimental-features = [ "nix-command" "flakes" ];
      };
      # Automatic garbage collection
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
    # CLI Utils
    direnv
    # Libs
    jdk21
    nvidia-vaapi-driver
    ntfs3g
    inputs.nix-alien.packages.${system}.nix-alien
  ];

  # Placeholders
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.nano.enable = false;
  services.flatpak.enable = true;
}
