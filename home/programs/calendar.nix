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
  options.program.calendar = mkEnableOption "Enable default calendar settings";

  config = mkIf cfg {
    accounts.calendar = {
      basePath = ".local/share/calendar";
      accounts = {
        "Personal" = {
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
      };
    };

    programs.khal = {
      enable = true;
      locale = {
        firstweekday = 0;
      };
    };

    programs.vdirsyncer = {
      enable = true;
      statusPath = "${config.xdg.configHome}/vdirsyncer/status";
    };
  };
}
