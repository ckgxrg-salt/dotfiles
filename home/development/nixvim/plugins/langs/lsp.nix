{
  plugins.lspconfig.enable = true;
  lsp = {
    inlayHints.enable = true;
    servers = {
      clangd.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      ts_ls.enable = true;
      cssls.enable = true;
    };
  };
}
