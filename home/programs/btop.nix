{ config, lib, ... }:
with lib;
let
  cfg = config.program.btop;
in
{
  options.program.btop = mkEnableOption "Enable btop system monitor";

  config = mkIf cfg {
    stylix.targets.btop.enable = true;

    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
  };
}
