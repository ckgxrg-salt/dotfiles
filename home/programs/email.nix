{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.email;
in
{
  options.program.email = {
    enable = mkEnableOption "Enable default email settings";
    autoRefresh = mkEnableOption "Automatically refresh Gmail OAuth token everyday";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      oauth2l
    ];

    # Auto refresh token every day
    systemd.user = {
      services."oauth2l-refresh" =
        let
          script = pkgs.writeShellScript "oauth2l-refresh" ''
            TOKEN=$(${pkgs.oauth2l}/bin/oauth2l fetch \
                        --cache ${config.home.homeDirectory}/.oauth2l \
                        --scope https://mail.google.com \
                        --credentials ${config.xdg.configHome}/sops-nix/secrets/gmail-oauth \
                        --refresh \
                        --disableAutoOpenConsentPage \
                        --consentPageInteractionTimeout=0 \
                        --consentPageInteractionTimeoutUnits=seconds)
            # Then validate
            STATUS=$(${pkgs.oauth2l}/bin/oauth2l test --token $TOKEN)
            exit $STATUS
          '';
        in
        mkIf cfg.autoRefresh {
          Unit = {
            Description = "Refresh Gmail OAuth Tokens";
            After = [ "sops-nix.service" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${script}";
            Restart = "on-failure";
            RestartSec = 60;
          };
        };
      timers."oauth2l-refresh" = mkIf cfg.autoRefresh {
        Unit = {
          Description = "Refresh Gmail OAuth Tokens everyday";
        };
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };

    accounts.email = {
      maildirBasePath = ".local/share/maildir";
      accounts = {
        "General" = {
          primary = true;
          address = "ckgxrg@ckgxrg.io";
          realName = "ckgxrg";
          userName = "ckgxrg@ckgxrg.io";
          passwordCommand = "cat ${config.xdg.configHome}/sops-nix/secrets/private-email";
          maildir.path = "ckgxrg@ckgxrg.io";

          imap = {
            host = "mail.privateemail.com";
            port = 993;
            tls.enable = true;
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
          };
          smtp = {
            host = "mail.privateemail.com";
            port = 465;
            tls.enable = true;
          };
          msmtp.enable = true;

          aerc = {
            enable = true;
            extraAccounts = {
              outgoing = "msmtp --read-envelope-from --read-recipients";
            };
          };
        };

        "Gmail" = {
          address = "ckgxrg@gmail.com";
          realName = "ckgxrg";
          userName = "ckgxrg@gmail.com";
          passwordCommand = "oauth2l fetch --cache ${config.home.homeDirectory}/.oauth2l --refresh --scope https://mail.google.com --credentials ${config.xdg.configHome}/sops-nix/secrets/gmail-oauth";
          maildir.path = "ckgxrg@gmail.com";

          flavor = "gmail.com";
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            extraConfig.account = {
              AuthMechs = "XOAUTH2";
            };
          };
          msmtp = {
            enable = true;
            extraConfig = {
              auth = "oauthbearer";
            };
          };

          aerc = {
            enable = true;
            extraAccounts = {
              outgoing = "msmtp --read-envelope-from --read-recipients";
              copy-to = null;
              postpone = "[Gmail]/Drafts";
            };
          };
        };
      };
    };

    programs.mbsync = {
      enable = true;
      package = pkgs.isync.override {
        withCyrusSaslXoauth2 = true;
      };
    };

    programs.msmtp.enable = true;

    programs.aerc = {
      enable = true;
      extraConfig = {
        general = {
          # Nix...
          unsafe-accounts-conf = true;
        };
        ui = {
          mouse-enabled = true;
          styleset-name = "nord";
        };
        compose = {
          address-book-cmd = "khard email --parsable %s";
          header-layout = "To|From,Cc|Bcc,Subject";
        };
        hooks = {
          aerc-startup = "hyprctl dispatch exec mbsync -a";
          mail-received = "notify-send -i mail-message \"[$AERC_ACCOUNT/$AERC_FOLDER] New mail from $AERC_FROM_NAME\" \"$AERC_SUBJECT\"";
          mail-deleted = "hyprctl dispatch exec mbsync \"$AERC_ACCOUNT:$AERC_FOLDER\"";
          mail-added = "hyprctl dispatch exec mbsync \"$AERC_ACCOUNT:$AERC_FOLDER\"";
        };
        statusline = {
          display-mode = "icon";
        };
        filters = {
          "text/plain" = "colorize";
          "text/calendar" = "calendar";
          "message/delivery-status" = "colorize";
          "message/rfc822=colorize" = "colorize";
          "text/html" = "! w3m -T text/html -I UTF-8";
          ".headers" = "colorize";
        };
      };
    };
  };
}
