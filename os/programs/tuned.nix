{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.tuned;
in
{
  options.program.tuned = {
    enable = mkEnableOption "Enable default TuneD settings";
  };

  config = mkIf cfg.enable {
    services.tuned = {
      enable = true;
      ppdSupport = true;
      settings = {
        daemon = true;
        dynamic_tuning = true;
      };
    };
  };
}
