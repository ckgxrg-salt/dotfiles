{ config, lib, ... }:
let
  cfg = config.program.nix;
in
{
  options.program.nix = {
    enable = lib.mkEnableOption "Enable default Nix settings";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      channel.enable = false;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };
      settings = {
        substituters = [
          "https://cache.nixos.org"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    programs.nh = {
      enable = true;
    };

    nixpkgs = {
      hostPlatform = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };
  };
}
