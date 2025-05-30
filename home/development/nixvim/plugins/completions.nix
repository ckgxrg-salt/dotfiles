{ config, lib, ... }:
{
  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim.plugins = {
      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;
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
                    buffer = ' ',
                    path = ' ',
                }
                item.menu = menu_icon[entry.source.name]
                return item
              end
            '';
          };
          sources = [
            { name = "luasnip"; }
            { name = "treesitter"; }
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          # Cmp / Luasnip: Handle keymaps themselves
          mapping.__raw = ''
            cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
          '';
        };
      };
      # Addons for Cmp
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-treesitter.enable = true;
      # Snippet Engine
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
        };
      };
      # Some ready-to-use snippets
      friendly-snippets.enable = true;

      # Quick pair letters
      nvim-surround = {
        enable = true;
      };

      # Auto generate paired letters
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
  };
}
