{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.pass;
in
{
  options.program.pass = {
    enable = mkEnableOption "Enable pass password manager";
  };

  config = mkIf cfg.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.pass-wayland;
      settings = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
        PASSWORD_STORE_CLIP_TIME = "20";
      };
    };

    services.pass-secret-service = {
      enable = true;
      storePath = "${config.xdg.dataHome}/password-store";
    };

    programs.browserpass = {
      enable = true;
    };
  };
}
