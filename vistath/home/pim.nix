{ config, pkgs, ... }:
# Calendar, Contacts and Emails
{
  # Info from the private repository
  ckgxrg = {
    calendar.enable = true;
    contacts.enable = true;
    email.enable = true;
  };

  # Calendar & Contacts
  programs.khal = {
    enable = true;
    locale = {
      firstweekday = 0;
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
      vcard = {
        private_objects = [
          "Matrix"
          "Twitter"
          "WhatsApp"
          "QQ"
        ];
      };
    };
  };
  programs.vdirsyncer = {
    enable = true;
    statusPath = "${config.xdg.configHome}/vdirsyncer/status";
  };

  # Mail utilities
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

  # ImapNotify
  services.imapnotify.enable = true;
}
