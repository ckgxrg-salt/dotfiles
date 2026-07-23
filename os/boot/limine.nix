{
  config,
  lib,
  ...
}:
let
  cfg = config.boot.limine;
in
{
  options.boot.limine = {
    enable = lib.mkEnableOption "Enable default settings for Limine bootloader";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      biosSupport = false;
      style.wallpapers = lib.mkForce [ ];
    };
  };
}
