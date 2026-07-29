{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.steam;
in
{
  options.program.steam = {
    enable = lib.mkEnableOption "Enable default Steam & Gamescope settings";
  };

  config = lib.mkIf cfg.enable {
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
