{ ... }:
{
  programs.nixvim.plugins = {
    # Quickfix list
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
        auto_jump = [
          "lsp_definitions"
        ];
        cycle_results = true;
        icons = true;
      };
    };
    # Better quickfix
    nvim-bqf = {
      enable = true;
      autoEnable = true;
    };
    # Treesitter
    treesitter = {
      enable = true;
      gccPackage = null;
    };
  };
}
