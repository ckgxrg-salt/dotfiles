{ config, ... }:
# direnv
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    nix-direnv.enable = true;
    silent = true;
  };
}
