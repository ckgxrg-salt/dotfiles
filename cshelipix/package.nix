{ pkgs, inputs, ... }: {
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
      trusted-users = [ "root" "@wheel" ];
      # Enable flakes
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # An advanced cli for Nix
  programs.nh ={
    enable = true;
    flake = "/home/ckgxrg/dotfiles";
    # Automatic garbage collection
    clean = {
      enable = true;
      extraArgs = "--delete-older-than 7d";
    };
  };

  # Allow unfree and insecure packages
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ inputs.rust-overlay.overlays.default ];
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
    (let base = pkgs.appimageTools.defaultFhsEnvArgs;
    in pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs:
        ((base.targetPkgs pkgs) ++ [ pkgs.pkg-config pkgs.ncurses ]);
      profile = "export FHS=1";
      runScript = "zsh";
      extraOutputsToInstall = [ "dev" ];
    }))
  ];

  # Placeholders
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.nano.enable = false;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
}
