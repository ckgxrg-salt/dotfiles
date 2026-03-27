{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.auto-cpufreq;
in
{
  options.program.auto-cpufreq = {
    enable = mkEnableOption "Enable default auto-cpufreq settings";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = true;
    };
  };
}
