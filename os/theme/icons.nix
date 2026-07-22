{ config, lib, ... }:
let
  cfg = config.theme.icons;
in
{
  options.theme.icons = with lib.types; {
    name = lib.mkOption {
      type = types.nullOr types.str;
      default = null;
    };
    package = lib.mkOption {
      type = types.nullOr types.package;
      default = null;
    };
  };

  config = {
    environment.systemPackages = lib.mkIf (cfg.package != null) [ cfg.package ];
  };
}
