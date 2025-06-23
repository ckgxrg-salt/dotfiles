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
  };

  config = mkIf cfg.default {
    #========== Localisation ==========#
    # Timezone, Locale
    time.timeZone = cfg.timezone;
    services.timesyncd.enable = false;
    services.chrony.enable = true;

    i18n = {
      defaultLocale = "en_GB.UTF-8";
      supportedLocales = [
        "zh_CN.UTF-8/UTF-8"
        "en_GB.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    };
  };
}
