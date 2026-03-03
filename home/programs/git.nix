{ config, lib, ... }:
with lib;
let
  cfg = config.program.git;
in
{
  options.program.git = {
    enable = mkEnableOption "Enable default git settings";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      signing = {
        signByDefault = true;
        key = "AC41 E882 B518 0369 8DCC 67F6 7050 0A63 15A4 4858";
      };
      settings = {
        user = {
          name = "ckgxrg";
          email = "ckgxrg@ckgxrg.io";
        };
        pull.rebase = true;
      };
    };
  };
}
