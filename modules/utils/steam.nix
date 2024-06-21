{ config, ... }:
{
  # Steam and Gamescope Settings
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  }
}