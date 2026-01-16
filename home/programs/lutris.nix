{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.lutris;
in
{
  options.program.lutris = {
    enable = mkEnableOption "Enable default Lutris settings";
  };

  config = mkIf cfg.enable {
    programs.lutris = {
      enable = true;
      defaultWinePackage = pkgs.proton-ge-bin;
      steamPackage = osConfig.programs.steam.package;
    };
  };
}
