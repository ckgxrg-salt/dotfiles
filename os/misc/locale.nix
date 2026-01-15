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
    # Timezone, Locale
    services.timesyncd.enable = false;
    services.chrony.enable = true;

    time.timeZone = mkIf (!cfg.autoTimezone) cfg.timezone;

    services.tzupdate.enable = cfg.autoTimezone;
    systemd.timers = mkIf cfg.autoTimezone {
      tzupdate.timerConfig.OnCalendar = mkForce null;
    };

    i18n = {
      defaultLocale = "en_GB.UTF-8";
      supportedLocales = [
        "zh_CN.UTF-8/UTF-8"
        "en_GB.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "zh_CN.UTF-8";
        LC_MEASUREMENT = "zh_CN.UTF-8";
        LC_MONETARY = "zh_CN.UTF-8";
        LC_NAME = "zh_CN.UTF-8";
        LC_NUMERIC = "zh_CN.UTF-8";
        LC_PAPER = "zh_CN.UTF-8";
        LC_TELEPHONE = "zh_CN.UTF-8";
        LC_TIME = "zh_CN.UTF-8";
      };
    };
  };
}
