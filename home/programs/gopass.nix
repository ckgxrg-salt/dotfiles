{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.gopass;
in
{
  options.program.gopass.enable = mkEnableOption "Enable gopass secret manager";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gopass-jsonapi ];

    programs.password-store = {
      enable = true;
      package = pkgs.gopass;
    };

    # freedesktop.org complaint system keyring
    services.pass-secret-service = {
      enable = true;
      storePath = "${config.xdg.dataHome}/password-store";
    };
  };
}
