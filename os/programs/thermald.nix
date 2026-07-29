{ config, lib, ... }:
let
  cfg = config.program.thermald;
in
{
  options.program.thermald = {
    enable = lib.mkEnableOption "Enable default thermald settings";
  };

  config = lib.mkIf cfg.enable {
    services.thermald = {
      enable = true;
    };
  };
}
