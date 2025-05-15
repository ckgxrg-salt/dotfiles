{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.terminal.alacritty;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.terminal.alacritty = {
    enable = mkEnableOption "ckgxrg's Alacritty Configurations";
    theme = mkOption {
      type = types.nullOr types.package;
      description = "The theme package to use";
      default = null;
    };
    settings = mkOption {
      type = tomlFormat.type;
      description = "Alacritty configuration";
      default = { };
    };
  };

  config =
    let
      generalConfig = (tomlFormat.generate "alacritty-general" cfg.settings).overrideAttrs (
        _finalAttrs: prevAttrs: {
          buildCommand = lib.concatStringsSep "\n" [
            prevAttrs.buildCommand
            "substituteInPlace $out --replace-quiet '\\\\' '\\'"
          ];
        }
      );
    in
    mkIf cfg.enable {
      home.packages = [ pkgs.alacritty ];

      xdg.configFile."alacritty/alacritty.toml".text =
        "general.import = ["
        + "\"${generalConfig}\""
        + optionalString (cfg.theme != null) ", \"${cfg.theme}/theme.toml\""
        + "]";
    };
}
