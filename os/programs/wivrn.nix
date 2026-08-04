{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.wivrn;
in
{
  options.program.wivrn = {
    enable = lib.mkEnableOption "Enable default WiVRn settings";
  };

  config = lib.mkIf cfg.enable {
    services.wivrn = {
      enable = true;
      highPriority = true;
      autoStart = false;
      openFirewall = true;
      package = pkgs.wivrn.override { cudaSupport = true; };

      steam = {
        enable = true;
        importOXRRuntimes = true;
      };
    };
  };
}
