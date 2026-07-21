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
    # TODO: matugen

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
