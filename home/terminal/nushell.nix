{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.terminal.nushell;
in
{
  options.terminal.nushell = {
    enable = mkEnableOption "ckgxrg's nushell configurations";
    theme = mkOption {
      type = types.nullOr types.package;
      description = "The theme package to use";
      default = null;
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
      configFile.text =
        ''
          $env.config = {
            show_banner: false
            error_style: "fancy"
            table: {
              mode: reinforced
              index_mode: auto
            }
            completions: {
              case_sensitive: false
              algorithm: "fuzzy"
            }
            filesize: {
              unit: metric
            }
          }

          $env.MANPAGER = "nvim +Man!";
          def ciallo [] { fortune | cowsay | lolcat }
          alias deploy = nh os switch --ask
          alias purge = nh clean all --ask
          alias dotfiles = cd ~/.config/nixos/system
        ''
        + cfg.settings
        + optionalString (cfg.theme != null) "source ${cfg.theme}/theme.nu";
    };
  };
}
