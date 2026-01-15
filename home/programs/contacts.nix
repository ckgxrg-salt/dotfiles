{ config, lib, ... }:
with lib;
let
  cfg = config.program.contacts;
in
{
  options.program.contacts = {
    enable = mkEnableOption "Enable default contacts settings";
  };

  config = mkIf cfg.enable {
    accounts.contact = {
      basePath = ".local/share/contacts";
      accounts = {
        "contacts" = {
          remote = {
            type = "carddav";
            url = "https://welkin.ckgxrg.io/cloud/remote.php/dav/addressbooks/users/ckgxrg/contacts/";
            userName = "ckgxrg";
            passwordCommand = [
              "cat"
              "${config.xdg.configHome}/sops-nix/secrets/welkin-passwd"
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
                "contacts"
                "contacts"
                "."
              ]
            ];
            conflictResolution = "remote wins";
          };

          khard = {
            enable = true;
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

  };
}
