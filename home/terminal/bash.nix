{ config, lib, ... }:
let
  cfg = config.terminal.bash;
in
{
  options.terminal.bash = {
    enable = lib.mkEnableOption "Enable default bash settings";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableBashIntegration = true;
    home.shellAliases = {
      deploy = "nh os switch . --ask";
      rm = "rm -i";
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      sessionVariables = {
        MANPAGER = "nvim +Man!";
      };
    };
  };
}
