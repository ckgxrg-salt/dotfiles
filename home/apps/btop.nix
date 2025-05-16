{ config, lib, ... }:
with lib;
let
  cfg = config.apps.btop;
in
{
  options.apps.btop = mkEnableOption "Enable btop system monitor";

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
