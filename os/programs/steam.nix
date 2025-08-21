{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.steam;
in
{
  options.program.steam = mkEnableOption "Enable default Steam & Gamescope settings";

  config = mkIf cfg {
    # Steam and Gamescope Settings
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      gamescopeSession = {
        enable = true;
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
