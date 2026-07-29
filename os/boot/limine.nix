{ lib, ... }:
{
  config = {
    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      biosSupport = false;
      style.wallpapers = lib.mkForce [ ];
    };
  };
}
