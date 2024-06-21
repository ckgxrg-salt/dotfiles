{ config, pkgs, ... }:
{
  # Aylur's GTK Shell
  programs.ags = {
    enable = true;
    configDir = ./ags-config;
    #extraPackages
  };
}