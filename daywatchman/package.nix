{ pkgs, inputs, ... }:
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
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "cinny-4.2.2"
        "cinny-unwrapped-4.2.2"
        "electron-30.5.1"
      ];
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # CLI Utils
    direnv
    powertop
    # Libs
    wl-clipboard
    # FHS Env
    inputs.nix-alien.packages.${system}.nix-alien
  ];

  # Placeholders
  programs.nano.enable = false;
}
