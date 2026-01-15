{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.calendar;
in
{
  options.program.calendar = {
    enable = mkEnableOption "Enable default calendar settings";
  };

  config = mkIf cfg.enable {
    accounts.calendar = {
      basePath = ".local/share/calendar";
      accounts = {
        "personal" = {
          remote = {
            type = "caldav";
            url = "https://welkin.ckgxrg.io/cloud/remote.php/dav/calendars/ckgxrg/";
            userName = "ckgxrg";
            passwordCommand = [
              "cat"
              "${config.xdg.configHome}/sops-nix/secrets/welkin-passwd"
            ];
          };
          local = {
            type = "filesystem";
            fileExt = ".ics";
          };
          vdirsyncer = {
            enable = true;
            collections = [
              "from a"
              "from b"
            ];
            conflictResolution = "remote wins";
          };

          khal = {
            enable = true;
            addresses = [
              "ckgxrg@ckgxrg.io"
              "ckgxrg@gmail.com"
              "ckgxrg@outlook.com"
            ];
            type = "discover";
          };
        };

        "solar_terms" = {
          remote = {
            type = "http";
            url = "https://raw.githubusercontent.com/KaitoHH/24-jieqi-ics/master/23_solar_terms_2015-01-01_2050-12-31.ics";
          };
          local = {
            type = "filesystem";
            fileExt = ".ics";
          };
          vdirsyncer = {
            enable = true;
            collections = null;
          };

          khal = {
            enable = true;
            color = "yellow";
            type = "calendar";
          };
        };

        "holidays_cn" = {
          remote = {
            type = "http";
            url = "https://www.thunderbird.net/media/caldata/autogen/ChinaHolidays.ics";
          };
          local = {
            type = "filesystem";
            fileExt = ".ics";
          };
          vdirsyncer = {
            enable = true;
            collections = null;
          };

          khal = {
            enable = true;
            color = "light red";
            type = "calendar";
          };
        };

        "holidays_uk" = {
          remote = {
            type = "http";
            url = "https://www.thunderbird.net/media/caldata/autogen/UKHolidays.ics";
          };
          local = {
            type = "filesystem";
            fileExt = ".ics";
          };
          vdirsyncer = {
            enable = true;
            collections = null;
          };

          khal = {
            enable = true;
            color = "light green";
            type = "calendar";
          };
        };
      };
    };

    programs.khal = {
      enable = true;
      locale = {
        firstweekday = 0;
        timeformat = "%H:%M";
      };
    };
  };
}
