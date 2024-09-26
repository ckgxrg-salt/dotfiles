{
  ckgxrg,
  ckgpkgs,
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
    enable = mkEnableOption "ckgxrg's Nushell Configurations";
    package = mkOption {
      type = types.package;
      default = pkgs.nushell;
    };
    theme = mkOption {
      type = types.package;
      default = ckgs.nu-scripts;
    };
    settings = mkOption {
      type = types.lines;
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
