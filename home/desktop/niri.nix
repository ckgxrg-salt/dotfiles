{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
# TODO: niri has bug with SHLVL, using systemd override for now, keep monitoring upstream
{
  options.desktop.niri = {
    enable = lib.mkEnableOption "Enable default niri settings";
  };

  config = lib.mkIf config.desktop.niri.enable {
    theme.matugen.templates.niri = {
      input_path = ../theme/templates/niri-colors.kdl;
      output_path = "${config.xdg.configHome}/niri/colors.kdl";
    };

    xdg.configFile = {
      "niri/config.kdl".source = ./niri.kdl;
      "niri/theme.kdl".text = ''
        cursor {
            xcursor-theme "${osConfig.theme.cursor.name}"
            xcursor-size ${toString osConfig.theme.cursor.size}
        }
      '';
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];
  };
}
