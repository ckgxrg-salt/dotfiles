{ config, lib, ... }:
let
  cfg = config.terminal.accessories;
in
{
  options.terminal.accessories = {
    enable = lib.mkEnableOption "Enable default terminal accessories";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.vivid = {
      input_path = ../theme/templates/vivid.yml;
      output_path = "${config.xdg.configHome}/vivid/themes/matugen.yml";
    };

    programs.pay-respects = {
      enable = true;
      options = [
        "--alias"
        "f"
      ];
    };

    programs.atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };

    programs.carapace = {
      enable = true;
    };

    programs.vivid = {
      enable = true;
      activeTheme = "matugen";
    };
  };
}
