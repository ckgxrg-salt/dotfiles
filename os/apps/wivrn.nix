{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.wivrn;
in
{
  options.apps.wivrn = mkEnableOption "Enable default WiVRn settings";

  config = mkIf cfg {
    services.wivrn = {
      enable = true;
      defaultRuntime = true;
      autoStart = false;
      openFirewall = true;

      config = {
        enable = true;
        json = {
          # Enter the desktop overlay by default
          application = [ pkgs.wlx-overlay-s ];
        };
      };
    };

    # Monado library
    hardware.graphics.extraPackages = with pkgs; [ monado-vulkan-layers ];
    environment.systemPackages = with pkgs; [ monado-vulkan-layers ];
  };
}
