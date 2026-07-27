{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.fortune;
in
{
  options.program.fortune = {
    enable = lib.mkEnableOption "Enable default fortune settings";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ fortune-kind ];

    # Allow manually place fortune cookies
    home.sessionVariables = {
      FORTUNE_DIR = "${config.home.homeDirectory}/.local/share/fortune";
    };
  };
}
