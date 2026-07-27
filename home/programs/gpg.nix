{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.gpg;
in
{
  options.program.gpg = {
    enable = lib.mkEnableOption "Enable default gpg settings";
  };

  config = lib.mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 34560000;
      pinentry = {
        package = pkgs.pinentry-qt;
      };
    };
  };
}
