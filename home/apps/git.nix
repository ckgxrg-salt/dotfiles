{ config, lib, ... }:
with lib;
let
  cfg = config.apps.git;
in
{
  options.apps.git = mkEnableOption "Enable default git settings";

  config = mkIf cfg {
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "ckgxrg";
      userEmail = "ckgxrg@ckgxrg.io";
      extraConfig = {
        pull.rebase = true;
        commit.gpgsign = true;
      };
    };
  };
}
