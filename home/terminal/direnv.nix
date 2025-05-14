{ config, lib, ... }:
with lib;
let
  cfg = config.terminal.direnv;
in
{
  options.terminal.direnv = mkEnableOption "Enable default direnv settings";

  config = mkIf cfg {
    programs.direnv = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
