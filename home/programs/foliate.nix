{ config, lib, ... }:
with lib;
let
  cfg = config.program.foliate;
in
{
  options.program.foliate = {
    enable = mkEnableOption "Enable default Foliate settings";
  };

  config = mkIf cfg.enable {
    stylix.targets.foliate.enable = true;

    programs.foliate = {
      enable = true;
      settings = {
        "viewer/font" = {
          default-size = 24;
        };
      };
    };
  };
}
