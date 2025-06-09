{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.terminal.accessories;
in
{
  options.terminal.accessories = mkEnableOption "Enable default terminal accessories";

  config = mkIf cfg {
    programs.pay-respects = {
      enable = true;
      options = [
        "--alias"
        "f"
      ];
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };

    programs.atuin = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
      daemon.enable = true;
      flags = [ "--disable-up-arrow" ];
    };

    programs.carapace = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };

    home.packages = with pkgs; [
      vivid
    ];
  };
}
