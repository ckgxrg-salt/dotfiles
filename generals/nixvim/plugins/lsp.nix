{ pkgs, ... }:
{
  # Language servers
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      clangd.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      denols.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };
}
