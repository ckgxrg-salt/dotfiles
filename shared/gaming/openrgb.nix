{ pkgs, ... }:
# Controls RGB lights on the chassis
{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "intel";
  };

  environment.systemPackages = [pkgs.openrgb-with-all-plugins];
}
