{ config, lib, ... }:
with lib;
let
  cfg = config.apps.yazi;
in
{
  options.apps.yazi = mkEnableOption "Enable yazi terminal file manager";

  config = mkIf cfg {
    stylix.targets.yazi.enable = true;

    programs.yazi = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
      shellWrapperName = "yy";
      settings = {
        manager = {
          show_symlink = true;
        };
        preview = {
          wrap = "yes";
        };
      };
    };
  };
}
