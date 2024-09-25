{ ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./security.nix
    ./package.nix
    ../generals/dev/podman.nix
    ../generals/utils/steam.nix
    ../generals/login/howdy.nix
    ../generals/login/greetd.nix
  ];

  system.stateVersion = "24.05";
}
