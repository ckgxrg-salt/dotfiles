{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.boot.limine;
in
{
  options.boot.limine = {
    enable = mkEnableOption "Enable default settings for Limine bootloader";
  };

  config = mkIf cfg.enable {
    # TODO: matugen

    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      biosSupport = false;
    };
  };
}
