{ pkgs, ... }:
{
  # Add some plugins that are not officially supported by Nixvim. 
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      hover-nvim
    ];
    extraConfigLua = ''
      require('hover').setup {
        init = function()
          require('hover.providers.lsp')
          require('hover.providers.diagnostic')
          require('hover.providers.dap')
          require('hover.providers.fold_preview')
        end,
        preview_opts = {
          border = 'single';
        },
        title = true,
        mouse_providers = {
          'LSP'
        },
        mouse_delay = 1000
      }
    '';
  };
}
