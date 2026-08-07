{ config, lib, ... }:
let
  cfg = config.terminal.nushell;
in
{
  options.terminal.nushell = {
    enable = lib.mkEnableOption "ckgxrg's nushell configurations";
    settings = lib.mkOption {
      type = lib.types.lines;
      description = "Nushell configuration in Nu format";
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.nushell = {
      input_path = ../theme/templates/nushell-theme.nu;
      output_path = "${config.xdg.configHome}/nushell/theme.nu";
    };

    home.shell.enableNushellIntegration = true;
    home.shellAliases = {
      deploy = "nh os switch . --ask";
      rm = "rm -i";
    };

    programs.nushell = {
      enable = cfg.enable;
      configFile.text = ''
        $env.MANPAGER = "nvim +Man!";

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

          keybindings: [
            {
              name: reload_config
              modifier: none
              keycode: f5
              mode: [ emacs vi_insert vi_normal ]
              event: [
                { send: executehostcommand cmd: $"source ${config.xdg.configHome}/nushell/config.nu; source ${config.xdg.configHome}/nushell/theme.nu" }
              ]
            }
          ]
        }
      ''
      + "source theme.nu"
      + cfg.settings;
    };
  };
}
