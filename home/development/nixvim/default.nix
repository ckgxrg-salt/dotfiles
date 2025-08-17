{ config, lib, ... }:
with lib;
let
  cfg = config.development.nixvim;
in
{

  options.development.nixvim = {
    enable = mkEnableOption "Enable default Nixvim settings";
  };

  config = mkIf cfg.enable {
    stylix.targets.nixvim = {
      enable = true;
      plugin = "base16-nvim";
    };

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    }
    // (import ./settings.nix);
  };
}
