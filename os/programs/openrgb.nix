{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.openrgb;
in
{
  options.program.openrgb = {
    enable = lib.mkEnableOption "Enable default OpenRGB settings";
    loadDefault = lib.mkEnableOption "Load the default profile on resume";
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
    };

    environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];

    powerManagement.resumeCommands = lib.mkIf cfg.loadDefault ''
      ${pkgs.openrgb-with-all-plugins}/bin/.openrgb-wrapped --profile ${config.users.users.ckgxrg.home}/.config/OpenRGB/default.orp --config ${config.users.users.ckgxrg.home}/.config/OpenRGB
    '';
  };
}
