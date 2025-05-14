{ config, lib, ... }:
with lib;
let
  cfg = config.apps.nix;
in
{
  options.apps.nix = mkEnableOption "Enable default Nix settings";

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
      flake = "/home/ckgxrg/.config/nixos/system";
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
    };
  };
}
