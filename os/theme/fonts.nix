{ config, lib, ... }:
{
  options.theme.fonts = with lib.types; {
    name = lib.mkOption {
      type = types.str;
      default = builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0;
    };
    monospace = lib.mkOption {
      type = types.str;
      default = builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0;
    };
    sizes = {
      applications = lib.mkOption {
        type = types.int;
        default = 10;
      };
      desktop = lib.mkOption {
        type = types.int;
        default = 12;
      };
      terminal = lib.mkOption {
        type = types.int;
        default = 10;
      };
      popups = lib.mkOption {
        type = types.int;
        default = 12;
      };
    };
  };
}
