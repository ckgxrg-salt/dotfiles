{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.daemons.mako;
in
{
  options.daemons.mako = mkEnableOption "Enable mako notification daemon";

  config = mkIf cfg {
    stylix.targets.mako.enable = true;

    home.packages = [ pkgs.libnotify ];

    services.mako = {
      enable = true;
      settings = {
        output = "DP-1";
        anchor = "bottom-right";
        border-radius = 0;
        height = 150;
        width = 450;
        icons = true;
        max-icon-size = 64;
        max-visible = 3;
      };
    };
  };
}
