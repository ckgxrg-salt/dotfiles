{ config, ... }:
# Yazi the terminal file manager
{
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
        wrap = true;
      };
    };
  };
}
