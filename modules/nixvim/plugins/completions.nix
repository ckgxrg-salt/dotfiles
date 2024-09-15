{ ... }:
{
  programs.nixvim.plugins = {
    # Completion
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        sources = [
          { name = "buffer"; }
          { name = "cmdline"; }
          { name = "path"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
        ];
        # Cmp / Luasnip: Expand and select with Super-Tab
        mapping = {
          __raw = ''
          {
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  if require('luasnip').expandable() then
                    require('luasnip').expand()
                  else
                    cmp.confirm({
                      select = true,
                    })
                  end
              else
                fallback()
              end
            end),

            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require('luasnip').locally_jumpable(1) then
                require('luasnip').jump(1)
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                require('luasnip').jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }
          '';
        };
      };
    };
    # Addons for Cmp
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
    cmp_luasnip.enable = true;
    # Snippet Engine
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
      };
    };
    # Some ready-to-use snippets
    friendly-snippets.enable = true;

    # Auto-generate paired letters
    
  };
}