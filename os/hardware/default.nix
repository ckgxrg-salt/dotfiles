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
    hostCPU = mkOption {
      type = types.enum [
        "intel"
        "amd"
      ];
      description = "The host's CPU manufacturer";
    };
    laptop = mkEnableOption "Whether this is a laptop";
  };

  config = mkIf cfg.default {
    hardware = {
      cpu.intel.updateMicrocode = (cfg.hostCPU == "intel");
      cpu.amd.updateMicrocode = (cfg.hostCPU == "amd");
      enableRedistributableFirmware = true;
    };

    # Power Button Behaviour
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
    }
    // optionalAttrs cfg.laptop {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    # Let astal monitor battery
    services.upower = mkIf cfg.laptop {
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
