{ pkgs, ... }:
# GNU Privacy Guard
{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-rofi;
  };
}
