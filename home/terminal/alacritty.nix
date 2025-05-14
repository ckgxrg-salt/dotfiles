{
  ckgs,
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
  options.ckgxrg.alacritty = {
    enable = mkEnableOption "ckgxrg's Alacritty Configurations";
    theme = mkOption {
      type = types.package;
      description = "The theme package to use";
      default = ckgs.alacritty-themes;
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
      home.packages = [ cfg.package ];

      xdg.configFile."alacritty/alacritty.toml".text =
        "general.import = ["
        + "\"${generalConfig}\""
        + lib.optionalString (cfg.theme != null) ", \"${cfg.theme}/theme.toml\""
        + "]";
    };
}
