{ config, lib, ... }:
let
  cfg = config.terminal.zellij;
in
{
  options.terminal.zellij = {
    enable = lib.mkEnableOption "Enable default Zellij configuration";
    autostart = lib.mkEnableOption "Autostart Zellij on shell startup";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        show_startup_tips = false;
        ui = {
          pane_frames = {
            hide_session_name = true;
          };
        };

        keybinds.normal._children = [
          {
            unbind._args = [ "Ctrl q" ];
          }
        ];
      };
    };
  };
}
