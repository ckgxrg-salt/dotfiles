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
        # base0a from tokyo night storm
        fallback_color = "#0db9d7";
        prefer = "closest-to-fallback";
        contrast = 0;
        wallpaper = {
          set = false;
          command = "";
        };
      };
      inherit (cfg) templates;
    };
  };
}
