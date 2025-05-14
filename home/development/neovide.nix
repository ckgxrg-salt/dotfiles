{ config, lib, ... }:
with lib;
let
  cfg = config.development.neovide;
in
{
  options.development.neovide = mkEnableOption "Enable Neovide GUI";

  config = mkIf cfg {
    programs.neovide = {
      enable = true;
      settings = {
        font = {
          size = 18;
        };
      };
    };
  };
}
