{ pkgs, ... }:
# Controls RGB lights on the chassis
{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "intel";
  };

  environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];

  systemd.services."openrgb-default-profile" = {
    description = "Load default OpenRGB profile";
    requisite = [ "openrgb.service" ];
    after = [ "openrgb.service" ];
    script = "${pkgs.openrgb}/bin/openrgb --profile default";
    wantedBy = [ "openrgb.service" ];
  };
}
