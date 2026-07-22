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
    settings = mkOption {
      type = types.lines;
      description = "Nushell configuration in Nu format";
      default = "";
    };
  };

  config = mkIf cfg.enable {
    theme.matugen.templates.nushell = {
      input_path = ../theme/templates/nushell-theme.nu;
      output_path = "${config.xdg.configHome}/nushell/theme.nu";
    };

    home.shell.enableNushellIntegration = true;

    programs.nushell = {
      enable = cfg.enable;
      configFile.text = ''
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
        alias deploy = nh os switch . --ask
        alias purge = nh clean all --ask
        alias proj = cd ~/Projects
        alias rm = rm -i
      ''
      + "source theme.nu"
      + cfg.settings;
    };
  };
}
