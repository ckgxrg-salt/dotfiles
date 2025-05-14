{ config, lib, ... }:
with lib;
let
  cfg = config.apps.btop;
in
{
  options = {
    apps.btop = {
      enable = mkEnableOption "Enable btop system monitor";
      colorscheme = mkOption {
        type = types.str;
        description = "Colour scheme to be used";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
        color_theme = cfg.colorscheme;
      };
    };
  };
}
