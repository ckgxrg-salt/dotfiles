{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.chromium;
in
{
  options.apps.chromium = {
    enable = mkEnableOption "Enable Chromium web browser";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [
        "--enable-features=AcceleratedVideoEncoder"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];

      # Install these extensions since chromium cannot be configured declaratively

      # Disconnect
      # Browserpass
      # Surfingkeys
      # ublock origin
      # Tokyo Night Storm Theme
    };
  };
}
