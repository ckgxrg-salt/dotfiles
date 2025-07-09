{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.apps.calendar;
in
{
  options.apps.calendar = mkEnableOption "Enable default calendar settings";

  config = mkIf cfg {
    accounts.calendar = {
      basePath = ".local/share/calendar";
      accounts = {
        "Personal" = {
          primary = true;
          remote = {
            type = "caldav";
            url = "https://todo.welkin.ckgxrg.io/dav/principals/ckgxrg";
            userName = "ckgxrg";
            passwordCommand = [
              "cat"
              "${config.xdg.configHome}/sops-nix/secrets/caldav-token"
            ];
          };
          local = {
            type = "filesystem";
            fileExt = ".ics";
          };
          vdirsyncer = {
            enable = true;
            collections = [
              [
                "Calendar"
                "projects"
                "."
              ]
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
            color = "light blue";
            type = "calendar";
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
