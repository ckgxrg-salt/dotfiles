{ ... }: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./security.nix
    ./package.nix
    ../modules/dev/podman.nix
    ../modules/utils/steam.nix
  ];

  system.stateVersion = "24.05";
}
