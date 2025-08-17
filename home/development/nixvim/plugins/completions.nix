{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      luaConfig.pre = ''
        local luasnip = require('luasnip')
        local cmp = require('cmp')
      '';
      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        window = {
          completion.__raw = "cmp.config.window.bordered()";
          documentation.__raw = "cmp.config.window.bordered()";
        };
        formatting = {
          fields = [
            "abbr"
            "kind"
            "menu"
          ];
          format = ''
            function(entry, item)
              local menu_icon ={
                nvim_lsp = ' ',
                luasnip = '󰢱 ',
                path = ' ',
              }
              item.menu = menu_icon[entry.source.name]
              return item
            end
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "treesitter"; }
          { name = "path"; }
        ];
        mapping.__raw = ''
          {
            ['<CR>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                if luasnip.expandable() then
                  luasnip.expand()
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
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }
        '';
      };
    };

    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
      };
    };
    friendly-snippets.enable = true;

    nvim-surround = {
      enable = true;
    };

    nvim-autopairs = {
      enable = true;
      settings = {
        enable_check_bracket_line = false;
        fast_wrap = {
          after_key = "l";
          before_key = "h";
          map = "<M-e>";
          chars = [
            "{"
            "["
            "("
            "\""
            "'"
          ];
          cursor_pos_before = false;
          end_key = "$";
          highlight = "Search";
          highlight_grey = "Comment";
          keys = "abcdefghijklmnopqrstuvwxyz";
          pattern = "[=[[%'%\"%>%]%)%}%,]]=]";
        };
      };
    };
  };
}
