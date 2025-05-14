{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.steam;
in
{
  options.apps.steam = mkEnableOption "Enable default Steam & Gamescope settings";

  config = mkIf cfg {
    # Steam and Gamescope Settings
    programs.steam = {
      enable = true;
      fontPackages = with pkgs; [ maple-mono.NF-CN ];
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      gamescopeSession = {
        enable = true;
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      protontricks.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
