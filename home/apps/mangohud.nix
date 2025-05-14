{ config, lib, ... }:
with lib;
let
  cfg = config.apps.mangohud;
in
{
  options.apps.mangohud = mkEnableOption "Enable mangohud game HUD";

  config = mkIf cfg {
    programs.mangohud = {
      enable = true;
      settings = {
        vsync = 0;
        gamemode = true;
      };
    };
  };
}
