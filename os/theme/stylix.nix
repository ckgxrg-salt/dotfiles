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
        font-packages.enable = true;
        fontconfig.enable = true;
      };
    };
  };
}
