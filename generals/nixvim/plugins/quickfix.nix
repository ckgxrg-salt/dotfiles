{ ... }:
{
  programs.nixvim.plugins = {
    # Quickfix list
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
        auto_jump = true;
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
