{ config, lib, ... }:
with lib;
{
  config = mkIf config.stylix.enable {
    stylix.fonts = {
      sansSerif.name = builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0;
      serif.name = builtins.elemAt config.fonts.fontconfig.defaultFonts.serif 0;
      monospace.name = builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0;
      emoji.name = builtins.elemAt config.fonts.fontconfig.defaultFonts.emoji 0;

      sansSerif.package = builtins.elemAt config.fonts.packages 0;
      serif.package = builtins.elemAt config.fonts.packages 0;
      monospace.package = builtins.elemAt config.fonts.packages 0;
      emoji.package = builtins.elemAt config.fonts.packages 0;
    };
  };
}
