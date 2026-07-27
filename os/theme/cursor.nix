{ config, lib, ... }:
let
  cfg = config.theme.cursor;
in
{
  options.theme.cursor = {
    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
    };
    size = lib.mkOption {
      type = lib.types.int;
      default = 32;
    };
  };

  config = {
    environment.systemPackages = lib.mkIf (cfg.package != null) [ cfg.package ];
    environment.variables.XCURSOR_SIZE = toString cfg.size;
  };
}
