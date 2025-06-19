{
  config,
  lib,
  ...
}:
{
  imports = [
    ./java.nix
    ./rust.nix
    ./formats.nix
  ];

  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim.plugins.lspconfig.enable = true;
    programs.nixvim.lsp = {
      inlayHints.enable = true;
      servers = {
        clangd.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
      };
    };
  };
}
