{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.terminal.direnv;
in
{
  options.terminal.direnv = {
    enable = lib.mkEnableOption "Enable default direnv settings";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.lixPackageSets.stable.nix-direnv;
      };
      silent = true;
    };
  };
}
