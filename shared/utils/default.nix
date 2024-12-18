{ pkgs, ... }:
# Miscellaneous gadgets
{
  # GNU Privacy Guard
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-rofi;
  };

  # Git VCS
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "ckgxrg";
    userEmail = "ckgxrg@ckgxrg.io";
    extraConfig = {
      pull.rebase = true;
      commit.gpgsign = true;
    };
  };
}
