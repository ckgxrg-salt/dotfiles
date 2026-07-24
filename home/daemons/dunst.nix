{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.daemons.dunst;
  dunst-workaround = pkgs.writeShellScript "dunst-workaround.sh" ''
    cd ${config.xdg.configHome}/dunst
    cat dunstrc dunst-theme > dunstrc-merged
    systemctl --user restart dunst.service
  '';
in
{
  options.daemons.dunst = {
    enable = lib.mkEnableOption "Enable dunst notification daemon";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.dunst = {
      input_path = ../theme/templates/dunst-theme;
      output_path = "${config.xdg.configHome}/dunst/dunst-theme";
      post_hook = "${dunst-workaround}";
    };

    home.packages = [ pkgs.libnotify ];

    services.dunst = {
      enable = true;
      configFile = "${config.xdg.configHome}/dunst/dunstrc-merged";
      settings = {
        global = {
          enable_recursive_icon_lookup = true;
          icon_theme = osConfig.theme.icons.name;
          origin = "bottom-right";
          font = "${osConfig.theme.fonts.name} ${toString osConfig.theme.fonts.sizes.popups}";
          dmenu = "vicinae dmenu -p Actions";
          mouse_left_click = "close_current";
          mouse_right_click = "context";
        };
      };
    };
  };
}
