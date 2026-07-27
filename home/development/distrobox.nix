{
  config,
  lib,
  ...
}:
let
  cfg = config.development.distrobox;
in
{
  options.development.distrobox = {
    enable = lib.mkEnableOption "Enable default distrobox settings";
  };

  config = lib.mkIf cfg.enable {
    programs.distrobox = {
      enable = true;
      enableSystemdUnit = false;
    };
  };
}
