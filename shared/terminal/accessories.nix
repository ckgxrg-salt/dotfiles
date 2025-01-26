{ config, pkgs, ... }:
{
  # thefuck Terminal Correction
  programs.thefuck = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
  };

  # atuin History
  programs.atuin = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    flags = [ "--disable-up-arrow" ];
  };

  # Carapace completions
  programs.carapace = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableNushellIntegration = config.programs.nushell.enable;
  };

  # Vivid the ls Color Generator
  home.packages = with pkgs; [
    vivid
  ];
}
