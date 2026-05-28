{ config, lib, ... }:
with lib;
let
  cfg = config.terminal.direnv;
in
{
  options.terminal.direnv = {
    enable = mkEnableOption "Enable default direnv settings";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
