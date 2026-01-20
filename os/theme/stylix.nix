{ config, lib, ... }:
with lib;
let
  cfg = config.stylix.default;
in
{
  options.stylix.default = mkEnableOption "Enable default stylix targets";

  config = mkIf cfg {
    stylix = {
      enable = true;
      autoEnable = false;
      targets = {
        gtk.enable = true;
        qt.enable = true;
      };
      fonts = {
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
  };
}
