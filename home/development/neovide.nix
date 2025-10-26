{ config, lib, ... }:
with lib;
let
  cfg = config.development.neovide;
in
{
  options.development.neovide = mkEnableOption "Enable Neovide GUI";

  config = mkIf cfg {
    stylix.targets.neovide.enable = true;

    programs.neovide.enable = true;

    programs.neovim.extraLuaConfig = ''
      if vim.g.neovide then
        vim.g.neovide_cursor_vfx_mode = "railgun"
      end
    '';
  };
}
