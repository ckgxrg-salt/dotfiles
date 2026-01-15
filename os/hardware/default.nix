{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware;
in
{
  options.hardware = {
    default = mkEnableOption "Apply default hardware settings";
  };

  config = mkIf cfg.default {
    hardware = {
      cpu.intel.updateMicrocode = (config.device.hostCPU == "intel");
      cpu.amd.updateMicrocode = (config.device.hostCPU == "amd");
      enableRedistributableFirmware = true;
    };

    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
    }
    // lib.optionalAttrs config.device.laptop {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    # Let astal monitor battery
    services.upower = lib.mkIf config.device.laptop {
      enable = true;
      percentageLow = 10;
      percentageAction = 3;
    };

    # Mouse & Touchpad
    services.libinput = {
      enable = true;
    };
  };
}
