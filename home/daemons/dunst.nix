{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.daemons.dunst;
in
{
  options.daemons.dunst = {
    enable = mkEnableOption "Enable dunst notification daemon";
  };

  config = mkIf cfg.enable {
    stylix.targets.dunst.enable = true;

    home.packages = [ pkgs.libnotify ];

    services.dunst = {
      enable = true;
      settings = {
        global = {
          origin = "bottom-right";
        };
      };
    };
  };
}
