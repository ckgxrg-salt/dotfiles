{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.chromium;
in
{
  options.program.chromium = {
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
        "--force-device-scale-factor=1.5"
      ];

      extensions = [
        { id = "jeoacafpbcihiomhlakheieifhpjdfeo"; } # Disconnect
        { id = "naepdomgkenhinolocfifgehidddafch"; } # Browserpass
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # ublock origin lite
      ];
    };
  };
}
