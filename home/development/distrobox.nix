{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.development.distrobox;
in
{
  options.development.distrobox = {
    enable = mkEnableOption "Enable default distrobox settings";
  };

  config = mkIf cfg.enable {
    programs.distrobox = {
      enable = true;
      enableSystemdUnit = false;
    };
  };
}
