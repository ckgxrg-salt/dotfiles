{
  config,
  osConfig,
  lib,
  ckgs,
  ...
}:
with lib;
let
  cfg = config.daemons.astal;
in
{
  options.daemons.astal = {
    enable = mkEnableOption "Enable Astal desktop widgets";
  };

  config =
    let
      package =
        if osConfig.device.hostname == "Daywatch" then
          ckgs.astal.daywatch
        else
          abort "No astal implementation for this device";
    in
    mkIf cfg.enable {
      home.packages = [ package ];

      systemd.user = {
        services = {
          "astal" = {
            Unit = {
              Description = "Astal Desktop Shell";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              Type = "exec";
              ExecStart = "${package}/bin/astal-shell";
              Restart = "on-failure";
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
          };
        };
      };
    };
}
