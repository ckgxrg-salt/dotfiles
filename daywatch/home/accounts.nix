{ ... }:
# Calendar, Contacts and Emails
{
  # Info from the private repository
  ckgxrg = {
    calendar.enable = true;
    email.enable = true;
    email.oauth.enable = true;
  };

  # Calendar & Contacts
  programs.khal = {
    enable = true;
    locale = {
      firstweekday = 0;
    };
  };
  programs.vdirsyncer = {
    enable = true;
    statusPath = "$XDG_CACHE_HOME/vdirsyncer/status";
  };

  # Mail utilities
  programs.astroid = {
    enable = false;
    externalEditor = "nvim -- -c 'set ft=mail' '+set fileencoding=utf-8' '+set ff=unix' '+set enc=utf-8' '+set fo+=w' %1";
    pollScript = "offlineimap";
  };
  programs.notmuch = {
    enable = true;
    maildir.synchronizeFlags = true;
  };
  programs.offlineimap.enable = true;
  programs.msmtp.enable = true;
  services.imapnotify.enable = true;
}
