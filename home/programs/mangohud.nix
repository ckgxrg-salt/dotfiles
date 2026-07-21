{ config, lib, ... }:
with lib;
let
  cfg = config.program.mangohud;
in
{
  options.program.mangohud = {
    enable = mkEnableOption "Enable mangohud game HUD";
  };

  config = mkIf cfg.enable {
    # TODO: Matugen

    programs.mangohud = {
      enable = true;
      settings = {
        vsync = 0;
        gamemode = true;
      };
    };
  };
}
