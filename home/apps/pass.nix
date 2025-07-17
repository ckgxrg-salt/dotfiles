{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.pass;
in
{
  options.apps.pass = mkEnableOption "Enable pass password manager";

  config = mkIf cfg {
    programs.password-store = {
      enable = true;
      package = pkgs.pass-wayland;
      settings = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
        PASSWORD_STORE_CLIP_TIME = "20";
      };
    };

    # Freedesktop.org complaint system keyring
    services.pass-secret-service = {
      enable = true;
      storePath = "${config.xdg.dataHome}/password-store";
    };

    # Browser integration
    programs.browserpass = {
      enable = true;
    };
  };
}
