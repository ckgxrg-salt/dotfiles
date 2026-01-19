{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.terminal.accessories;
in
{
  options.terminal.accessories = {
    enable = mkEnableOption "Enable default terminal accessories";
  };

  config = mkIf cfg.enable {
    stylix.targets.vivid.enable = true;

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
    };
  };
}
