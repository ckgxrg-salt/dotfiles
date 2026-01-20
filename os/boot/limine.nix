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
    stylix.targets.limine = {
      enable = true;
      image.enable = false;
      useWallpaper = false;
    };

    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      biosSupport = false;
    };
  };
}
