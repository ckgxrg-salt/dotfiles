{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.gpg;
in
{
  options.program.gpg = mkEnableOption "Enable default gpg settings";

  config = mkIf cfg {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableNushellIntegration = true;
      defaultCacheTtl = 3600;
      pinentry = {
        package = pkgs.pinentry-qt;
      };
    };
  };
}
