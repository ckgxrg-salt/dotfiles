{
  config,
  lib,
  ...
}:
# Override system default XDG sounds
with lib;
let
  cfg = config.ckgxrg.themes.sound;
in
{
  options.ckgxrg.themes.sound = {
    enable = mkEnableOption "Suppress default sound theme implementation";
  };
  config = mkIf cfg.enable {
    # We'll do it manually
    xdg.sounds.enable = false;
    environment.pathsToLink = [
      "/share/sounds"
    ];
  };
}
