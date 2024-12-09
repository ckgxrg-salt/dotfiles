{ ... }:
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
      "cinny-unwrapped-4.2.3"
      "olm-3.2.16"
    ];
  };

  # Placeholders
  programs.nano.enable = false;
  programs.hyprland = {
    enable = true;
    systemd.setPath.enable = true;
  };
  # XDG Portal Placeholder
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
