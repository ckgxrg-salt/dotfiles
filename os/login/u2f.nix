{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.login.u2f;
in
{
  options.login.u2f = {
    enable = mkEnableOption "Enable login via physical security key";
  };

  config = mkIf cfg.enable {
    # Allow physical security key unlock
    security.pam = {
      u2f.settings = {
        cue = true;
        cue_prompt = "Touch the security key...";
      };
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
        greetd.u2fAuth = true;
        polkit-1.u2fAuth = true;
      };
    };
  };
}
