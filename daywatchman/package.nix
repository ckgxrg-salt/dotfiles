{ inputs, pkgs, ... }:
{
  # Nix configuration
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
    # Enable flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # An advanced cli for Nix
  programs.nh = {
    enable = true;
    flake = "/home/ckgxrg/.config/nixos/system";
    # Automatic garbage collection
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--delete-older-than 7d";
    };
  };

  # Allow unfree and insecure packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
      "electron-30.5.1"
    ];
  };

  # Placeholders
  programs.nano.enable = false;
  programs.hyprland = {
    enable = true;
    systemd.setPath.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
