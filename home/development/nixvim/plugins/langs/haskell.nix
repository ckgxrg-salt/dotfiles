{
  plugins.haskell-tools = {
    enable = true;
    enableTelescope = true;
    # Since hls is ghc version sensitive, it's better to make it per project.
    hlsPackage = null;
    settings = {
      hls = {
        default_settings = {
          formattingProvider = "ormolu";
        };
      };
    };
  };

  extraFiles."after/ftplugin/haskell.lua".text = ''
    vim.keymap.set('n', '<leader>re', require('haskell-tools').lsp.buf_eval_all, { desc = 'Haskell: Evaluate all snippets', buffer = true })
    vim.keymap.set('n', '<leader>cs', require('haskell-tools').hoogle.hoogle_signature, { desc = 'Haskell: Show signature using Hoogle', buffer = true })
  '';
}
