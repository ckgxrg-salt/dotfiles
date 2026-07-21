{ config, lib, ... }:
with lib;
let
  cfg = config.program.yazi;
in
{
  options.program.yazi = {
    enable = mkEnableOption "Enable yazi terminal file manager";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
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
