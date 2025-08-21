{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.opencomposite;
in
{
  options.program.opencomposite = mkEnableOption "Enable OpenComposite OpenVR compatibility layer";

  config = mkIf cfg {
    # OpenComposite package
    home.packages = with pkgs; [ opencomposite ];

    # Translate SteamVR calls to OpenXR
    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
      {
        "config": [
          "${config.xdg.dataHome}/Steam/config"
        ],
        "external_drivers": [],
        "jsonid": "vrpathreg",
        "log": [
          "${config.xdg.dataHome}/Steam/logs"
        ],
        "runtime": [
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';

    # Use WiVRn as the OpenXR runtime
    xdg.configFile."openxr/1/active_runtime.json".source =
      "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";
  };
}
