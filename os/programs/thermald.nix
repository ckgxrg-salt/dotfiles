{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.thermald;
in
{
  options.program.thermald = {
    enable = mkEnableOption "Enable default thermald settings";
  };

  config = mkIf cfg.enable {
    services.thermald = {
      enable = true;
    };
  };
}
