{ config, lib, ... }:
with lib;
let
  cfg = config.theme.cursor;
in
{
  options.theme.cursor = {
    name = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Cursor theme to use";
    };
    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Cursor package to use";
    };
    size = mkOption {
      type = types.int;
      default = 32;
      description = "The cursor size";
    };
  };

  config = {
    environment.variables.XCURSOR_SIZE = toString cfg.size;
  };
}
