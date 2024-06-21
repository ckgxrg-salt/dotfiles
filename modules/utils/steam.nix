{ config, pkgs, ... }:
{
  # Steam and Gamescope Settings
  programs.steam = {
    enable = true;
    fontPackages = with pkgs; [ source-han-sans ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}