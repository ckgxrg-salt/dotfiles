{ config, lib, ... }:
with lib;
let
  cfg = config.program.nix;
in
{
  options.program.nix = mkEnableOption "Enable default Nix settings";

  config = mkIf cfg {
    # Nix configuration
    nix = {
      channel.enable = false;
      settings = {
        substituters = [
          "https://cache.nixos.org"
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
      flake = "/home/ckgxrg/Projects/dotfiles";
      # Automatic garbage collection
      clean = {
        enable = true;
        dates = "weekly";
      };
    };

    # Allow unfree and insecure packages
    nixpkgs = {
      hostPlatform = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "olm-3.2.16"
        ];
      };
      overlays = [
        (_: super: {
          hyprlandPlugins.hyprgrass = (
            super.hyprlandPlugins.hyprgrass.overrideAttrs {
              version = "0.8.2-unstable-2025-09-02";
              src = super.fetchFromGitHub {
                owner = "horriblename";
                repo = "hyprgrass";
                rev = "9b341353a91c23ced96e5ed996dda62fbe426a32";
                hash = "sha256-Nwd8JwGEEdGBJthxiopK51Fwva5TbM1PEOQDe+NAZEw=";
              };
            }
          );
        })
      ];
    };
  };
}
