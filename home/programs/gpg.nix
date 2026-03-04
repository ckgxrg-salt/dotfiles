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
  options.program.gpg = {
    enable = mkEnableOption "Enable default gpg settings";
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableNushellIntegration = true;
      defaultCacheTtl = 34560000;
      pinentry = {
        package = pkgs.pinentry-qt;
      };
    };
  };
}
