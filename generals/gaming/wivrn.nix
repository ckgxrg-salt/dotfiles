{ pkgs, ... }:
# An OpenXR streaming application to a standalone headset
# This module is nixos level
{
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
}
