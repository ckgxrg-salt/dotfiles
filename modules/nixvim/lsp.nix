{ ... }: {
  # Language servers
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      clangd.enable = true;
      cmake.enable = true;
      marksman.enable = true;
      nil-ls.enable = true;
    };
  };
}