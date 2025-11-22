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
      gc = {
        automatic = true;
        dates = "weekly";
      };
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
