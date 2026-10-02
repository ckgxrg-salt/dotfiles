{ config, lib, ... }:
let
  cfg = config.program.pi-agent;
in
{
  options.program.pi-agent = {
    enable = lib.mkEnableOption "Enable Pi coding agent";
  };

  config = lib.mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = true;
      configDir = "${config.xdg.configHome}/pi";
    };
  };
}
