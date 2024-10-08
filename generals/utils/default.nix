{ config, pkgs, ... }:
# Miscellaneous gadgets
{
  # GNU Privacy Guard
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Git VCS
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "ckgxrg";
    userEmail = "ckgxrg@ckgxrg.io";
    extraConfig = {
      pull.rebase = true;
    };
  };

  # Mpris Media Control
  services.mpdris2 = {
    enable = true;
    multimediaKeys = true;
    notifications = true;
    mpd.musicDirectory = config.xdg.userDirs.music;
  };
}
