{ config, lib, ... }:
{
  options.theme.fonts = {
    name = lib.mkOption {
      type = lib.types.str;
      default = builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0;
    };
    monospace = lib.mkOption {
      type = lib.types.str;
      default = builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0;
    };
    sizes = {
      applications = lib.mkOption {
        type = lib.types.int;
        default = 10;
      };
      desktop = lib.mkOption {
        type = lib.types.int;
        default = 12;
      };
      terminal = lib.mkOption {
        type = lib.types.int;
        default = 10;
      };
      popups = lib.mkOption {
        type = lib.types.int;
        default = 12;
      };
    };
  };
}
