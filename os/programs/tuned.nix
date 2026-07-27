{
  config,
  lib,
  ...
}:
let
  cfg = config.program.tuned;
in
{
  options.program.tuned = {
    enable = lib.mkEnableOption "Enable default TuneD settings";
  };

  config = lib.mkIf cfg.enable {
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
