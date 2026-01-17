{ config, lib, ... }:
with lib;
let
  cfg = config.misc.locale;
in
{
  options.misc.locale = {
    default = mkEnableOption "Apply default locale settings";
    timezone = mkOption {
      type = types.str;
      description = "Time zone of this host";
    };
    autoTimezone = mkEnableOption "Automatically determine time zone on startup";
  };

  config = mkIf cfg.default {
    services.timesyncd.enable = false;
    services.chrony.enable = true;

    time.timeZone = mkIf (!cfg.autoTimezone) cfg.timezone;

    services.tzupdate.enable = mkIf cfg.autoTimezone true;
    systemd.timers = mkIf cfg.autoTimezone {
      tzupdate.timerConfig = {
        OnCalendar = mkForce null;
        Persistent = mkForce null;
      };
    };

    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocales = [
        "zh_CN.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        # yyyy/mm/dd
        LC_TIME = "en_DK.UTF-8";
        LC_COLLATE = "C.UTF-8";
      };
    };
  };
}
