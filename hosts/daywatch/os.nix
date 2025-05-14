{ pkgs, ... }:
# Daywatch OS entrypoint
{
  networking.hostName = "Daywatch";
  system.stateVersion = "24.05";
  boot = {
    default = true;
    kernel = pkgs.linuxPackages_zen;
    bbr = true;
    laptop = true;
    noCoredump = true;
  };
  hardware = {
    default = true;
    secureBoot = true;
    laptop = true;
    cpu = "intel";
    gpu = "intel";
  };
  login = {
    greetd = {
      enable = true;
      greetMessage = "====> Daywatch <====";
    };
    users = {
      default = true;
      issue = "====> Daywatch <====";
    };
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Asia/Taipei";
    };
    security.default = true;
  };
  apps = {
    gamemode.enable = true;
    nix = true;
    steam = true;
  };
  theme.sound.enable = true;

  imports = [
    ./overrides/boot.nix
    ./overrides/fstab.nix
    ./overrides/greetd.nix
  ];
}
