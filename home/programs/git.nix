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
      settings = {
        user = {
          name = "ckgxrg";
          email = "ckgxrg@ckgxrg.io";
        };
        pull.rebase = true;
        commit.gpgsign = true;
      };
    };
  };
}
