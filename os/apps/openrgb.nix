{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.openrgb;
in
{
  options.apps.openrgb = {
    enable = mkEnableOption "Enable default OpenRGB settings";
    loadDefault = mkEnableOption "Load the default profile on startup";
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
    };

    environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];

    systemd.services."openrgb-default-profile" = mkIf cfg.loadDefault {
      description = "Load default OpenRGB profile";
      requisite = [ "openrgb.service" ];
      after = [ "openrgb.service" ];
      script = ''
        ${pkgs.openrgb}/bin/openrgb --profile ${config.users.users.ckgxrg.home}/.config/OpenRGB/default.orp
      '';
      serviceConfig.WorkingDirectory = "/var/empty";
      wantedBy = [ "openrgb.service" ];
    };

    powerManagement.resumeCommands = mkIf cfg.loadDefault ''
      ${pkgs.openrgb}/bin/openrgb --profile ${config.users.users.ckgxrg.home}/.config/OpenRGB/default.orp
    '';
  };
}
