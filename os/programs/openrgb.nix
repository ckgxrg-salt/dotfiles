{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.openrgb;
in
{
  options.program.openrgb = {
    enable = lib.mkEnableOption "Enable default OpenRGB settings";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.openrgb = {
      input_path = "/dev/null";
      post_hook = "openrgb --color {{ colors.primary.default.hex_stripped | saturate: 30, \"hsl\" }} &";
    };

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = config.device.hostCPU;
    };

    environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];
  };
}
