{ config, lib, ... }:
let
  cfg = config.program.keepassxc;
in
{
  options.program.keepassxc = {
    enable = lib.mkEnableOption "Enable KeePassXC password manager";
  };

  config = lib.mkIf cfg.enable {
    programs.keepassxc = {
      enable = true;
      autostart = true;
      settings = {
        General = {
          ConfigVersion = 2;
          MinimizeAfterUnlock = true;
        };
        Browser = {
          Enabled = true;
          AllowExpiredCredentials = false;
          AlwaysAllowAccess = true;
          BestMatchOnly = false;
          MatchUrlScheme = false;
        };
        GUI = {
          ApplicationTheme = "classic";
          MinimizeOnClose = true;
          MinimizeOnStartup = true;
          ShowTrayIcon = true;
          TrayIconAppearance = "monochrome-dark";
        };
        Security = {
          IconDownloadFallback = true;
        };
      };
    };

    services.gnome-keyring.enable = true;
  };
}
