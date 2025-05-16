{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.terminal.alacritty;
in
{
  options.terminal.alacritty = mkEnableOption "ckgxrg's default Alacritty configurations";

  config = mkIf cfg {
    stylix.targets.alacritty.enable = true;

    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 1.0;
          blur = true;
          decorations_theme_variant = "Dark";
          padding = {
            x = 18;
            y = 18;
          };
        };
      };
    };
  };
}
