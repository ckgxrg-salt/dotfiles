{ config, lib, ... }:
with lib;
let
  cfg = config.apps.contacts;
in
{
  options.apps.contacts = mkEnableOption "Enable default contacts settings";

  config = mkIf cfg {
    accounts.contact = {
      basePath = ".local/share/contacts";
      accounts = {
        "Contacts" = {
          remote = {
            type = "carddav";
            url = "https://davis.welkin.ckgxrg.io/dav/addressbooks/ckgxrg/contacts";
            userName = "ckgxrg";
            passwordCommand = [
              "cat"
              "${config.xdg.configHome}/sops-nix/secrets/dav-passwd"
            ];
          };
          local = {
            type = "filesystem";
            fileExt = ".vcf";
          };
          vdirsyncer = {
            enable = true;
            collections = [
              [
                "Contacts"
                "contacts"
                "."
              ]
            ];
            conflictResolution = "remote wins";
          };

          khard = {
            enable = true;
          };
          khal = {
            enable = true;
            addresses = [
              "ckgxrg@ckgxrg.io"
              "ckgxrg@gmail.com"
              "ckgxrg@outlook.com"
            ];
            color = "light blue";
          };
        };
      };
    };

    programs.khard = {
      enable = true;
      settings = {
        "contact table" = {
          display = "formatted_name";
          preferred_phone_number_type = [
            "pref"
            "cell"
          ];
          preferred_email_address_type = [
            "pref"
            "work"
            "home"
          ];
        };
      };
    };

    programs.vdirsyncer = {
      enable = true;
      statusPath = "${config.xdg.configHome}/vdirsyncer/status";
    };
  };
}
