{ config, lib, ... }:
with lib;
let
  cfg = config.terminal.bash;
in
{
  options.terminal.bash = {
    enable = mkEnableOption "Enable default bash settings";
  };

  config = mkIf cfg.enable {
    home.shell.enableBashIntegration = true;

    programs.bash = {
      enable = true;
      enableCompletion = true;
      sessionVariables = {
        MANPAGER = "nvim +Man!";
      };
      shellAliases = {
        "ciallo" = "fortune | cowsay | lolcat";
        "deploy" = "nh os switch --ask";
        "purge" = "nh clean all --ask";
        "clear" = "clear && ciallo";
        "rm" = "rm -i";
      };
    };
  };
}
