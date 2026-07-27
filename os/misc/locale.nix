{ config, lib, ... }:
let
  cfg = config.misc.locale;
in
{
  options.misc.locale = {
    default = lib.mkEnableOption "Apply default locale settings";
    timezone = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Timezone of this host";
    };
  };

  config = lib.mkIf cfg.default {
    services.timesyncd.enable = false;
    services.chrony.enable = true;

    time.timeZone = cfg.timezone;

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
