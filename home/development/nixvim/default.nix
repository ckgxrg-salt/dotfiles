{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.development.nixvim;
in
{

  options.development.nixvim = {
    enable = mkEnableOption "Enable default Nixvim settings";
  };

  config =
    let
      modules = [
        (import ./settings.nix)
        (import ./keymaps.nix)
        (import ./plugins pkgs lib)
      ];
      deepMerge = import ./merge.nix;
    in
    mkIf cfg.enable {
      stylix.targets.nixvim = {
        enable = true;
        plugin = "base16-nvim";
      };

      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        withRuby = false;
        withPython3 = false;
      }
      // lib.foldl deepMerge { } modules;
    };
}
