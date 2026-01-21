{ config, lib, ... }:
with lib;
let
  cfg = config.stylix.default;
in
{
  options.stylix.default = mkEnableOption "Enable default Stylix targets";

  config = mkIf cfg {
    stylix = {
      enable = true;
      autoEnable = false;
      targets = {
        gtk.enable = true;
        qt = {
          enable = true;
          standardDialogs = "xdgdesktopportal";
        };
      };
    };
  };
}
