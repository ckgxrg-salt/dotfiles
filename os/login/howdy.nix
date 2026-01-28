{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.login.howdy;
in
{
  options.login.howdy = {
    enable = mkEnableOption "Enable default Howdy settings";
  };

  config = mkIf cfg.enable {
    services.howdy = {
      enable = true;
      control = "sufficient";
      settings = {
        core = {
          detection_notice = true;
          workaround = "input";
        };
      };
    };

    services.linux-enable-ir-emitter = {
      enable = true;
    };

    # TODO: Workaround for Polkit for now
    systemd.services."polkit-agent-helper@".serviceConfig = {
      DeviceAllow = "char-video4linux rw";
      PrivateDevices = "no";
    };
  };
}
