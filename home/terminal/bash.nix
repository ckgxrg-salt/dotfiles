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

    programs.bash = {
      enable = true;
      enableCompletion = true;
      sessionVariables = {
        MANPAGER = "nvim +Man!";
      };
      shellAliases = {
        "ciallo" = "fortune | cowsay | lolcat";
        "deploy" = "nh os switch . --ask";
        "purge" = "nh clean all --ask";
        "rm" = "rm -i";
      };
    };
  };
}
