{ config, lib, ... }:
with lib;
let
  cfg = config.program.btop;
in
{
  options.program.btop = {
    enable = mkEnableOption "Enable btop system monitor";
  };

  config = mkIf cfg.enable {
    stylix.targets.btop.enable = true;

    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
  };
}
