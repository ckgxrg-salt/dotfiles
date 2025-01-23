{
  config,
  lib,
  pkgs,
  ...
}:
# Custom nushell module
with lib;
let
  cfg = config.ckgxrg.nushell;
in
{
  options.ckgxrg.nushell = {
    enable = mkEnableOption "ckgxrg's nushell configurations";
    package = mkOption {
      type = types.package;
      description = "The nushell package to use";
      default = pkgs.nushell;
    };
    theme = mkOption {
      type = types.package;
      description = "The theme package to use";
      default = ckgs.nu-scripts;
    };
    settings = mkOption {
      type = types.lines;
      description = "Nushell configuration in Nu format";
      default = '''';
    };
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = cfg.enable;
      configFile.text = "source ${cfg.theme}/theme.nu" + "\n" + cfg.settings;
    };
  };
}
