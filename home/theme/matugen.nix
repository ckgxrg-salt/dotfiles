{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.theme.matugen;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.theme.matugen = {
    templates = lib.mkOption {
      type = tomlFormat.type;
    };
  };

  config = {
    home.packages = with pkgs; [
      matugen
    ];

    xdg.configFile."matugen/templates" = {
      source = ./templates;
      recursive = true;
    };

    xdg.configFile."matugen/config.toml".source = tomlFormat.generate "matugen-config.toml" {
      config = {
        prefer = "closest-to-fallback";
        wallpaper.set = false;
      };
      inherit (cfg) templates;
    };
  };
}
