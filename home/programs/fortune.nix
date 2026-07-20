{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.fortune;
in
{
  options.program.fortune = {
    enable = mkEnableOption "Enable default fortune settings";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ fortune-kind ];

    # Allow manually place fortune cookies
    home.sessionVariables = {
      FORTUNE_DIR = "${config.home.homeDirectory}/.local/share/fortune";
    };
  };
}
