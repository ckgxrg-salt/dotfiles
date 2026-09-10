{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.nix;
  cudaSupport = config.device.hostGPU == "nvidia";
in
{
  options.program.nix = {
    enable = lib.mkEnableOption "Enable default Nix settings";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.lixPackageSets.stable.lix;
      channel.enable = false;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };
      settings = {
        trusted-users = [
          "@wheel"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        substituters = lib.mkIf cudaSupport [
          "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = lib.mkIf cudaSupport [
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
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
        inherit cudaSupport;
      };
    };
  };
}
