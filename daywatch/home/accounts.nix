{ ... }:
# Calendar, Contacts and Emails
{
  # Info from the private repository
  ckgxrg = {
    calendar.enable = true;
    contacts.enable = true;
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
  programs.khard = {
    enable = true;
  };
  programs.vdirsyncer = {
    enable = true;
    statusPath = "$XDG_CACHE_HOME/vdirsyncer/status";
  };

  # Mail utilities
  programs.offlineimap.enable = true;
  programs.msmtp.enable = true;
}
