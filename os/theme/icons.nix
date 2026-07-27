{ config, lib, ... }:
let
  cfg = config.theme.icons;
in
{
  options.theme.icons = {
    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
    };
  };

  config = {
    environment.systemPackages = lib.mkIf (cfg.package != null) [ cfg.package ];
  };
}
