{ config, lib, ... }:
{
  config = {
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
    }
    // lib.optionalAttrs config.device.laptop {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    services.upower = lib.mkIf config.device.laptop {
      enable = true;
      percentageLow = 10;
      percentageAction = 3;
    };
  };
}
