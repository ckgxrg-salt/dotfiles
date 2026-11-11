{ config, lib, ... }:
{
  config = {
    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "2h";
      HibernateOnACPower = "yes";
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

    services.upower = lib.mkIf config.device.laptop {
      enable = true;
      percentageLow = 10;
      percentageAction = 3;
    };
  };
}
