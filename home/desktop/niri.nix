{ config, lib, ... }:
with lib;
let
  cfg = config.desktop.niri;
in
{
  options.desktop.niri = {
    enable = mkEnableOption "Enable default niri settings";
  };

  config = mkIf cfg.enable {
    xdg.configFile."niri/default.kdl".source = ./niri.kdl;
  };
}
