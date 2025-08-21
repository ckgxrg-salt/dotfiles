{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.zk;
in
{
  options.program.zk = mkEnableOption "Enable zk note manager";

  config = mkIf cfg {
    # For interactive browser
    home.packages = [ pkgs.fzf ];

    programs.zk = {
      enable = true;
      settings = {
        extra.author = "ckgxrg";
        tool = {
          shell = "bash";
        };
      };
    };
  };
}
