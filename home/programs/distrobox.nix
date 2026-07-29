{ config, lib, ... }:
{
  options.program.distrobox = {
    enable = lib.mkEnableOption "Enable default distrobox settings";
  };

  config = lib.mkIf config.program.distrobox.enable {
    programs.distrobox = {
      enable = true;
      enableSystemdUnit = false;
    };
  };
}
