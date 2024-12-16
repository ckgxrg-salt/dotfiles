{ ... }:
# Calendar, Contacts and Emails
{
  # Info from the private repository
  ckgxrg = {
    calendar.enable = true;
  };

  # Utilities
  # khal
  programs.khal = {
    enable = true;
    locale = {
      firstweekday = 0;
    };
  };
  # vdirsyncer
  programs.vdirsyncer = {
    enable = true;
    statusPath = "$XDG_CACHE_HOME/vdirsyncer/status";
  };
}
