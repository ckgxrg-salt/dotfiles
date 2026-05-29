{ config, lib, ... }:
with lib;
let
  cfg = config.desktop.quickshell;
in
{
  options.desktop.quickshell = {
    enable = mkEnableOption "Enable default Quickshell settings";
  };

  config = mkIf cfg.enable {
  };
}
