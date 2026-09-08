{
  lib,
  pkgs,
  ...
}:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  options.theme.matugen = {
    templates = lib.mkOption {
      type = tomlFormat.type;
    };
  };
}
