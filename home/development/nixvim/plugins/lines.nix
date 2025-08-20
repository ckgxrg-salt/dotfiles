{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          diagnostics_indicator.__raw = ''
            function(count, level, diagnostics_dict, context)
              local s = " "
              for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                  or (e == "warning" and " " or " ")
                s = s .. n .. sym
              end
              return s
            end
          '';
          separator_style = "thin";
          numbers = "ordinal";
          close_command.__raw = ''
            function()
              MiniBufremove.delete()
            end
          '';
          right_mouse_command.__raw = ''
            function()
              MiniBufremove.delete()
            end
          '';
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
        };
      };
    };

    illuminate = {
      enable = true;
      underCursor = true;
      providers = [
        "lsp"
        "treesitter"
        "regex"
      ];
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = ":BufferLineCyclePrev<CR>";
      options.desc = "Previous tab";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = ":BufferLineCycleNext<CR>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "<C-1>";
      action = ":BufferLineGoToBuffer 1<CR>";
    }
    {
      mode = "n";
      key = "<C-2>";
      action = ":BufferLineGoToBuffer 2<CR>";
    }
    {
      mode = "n";
      key = "<C-3>";
      action = ":BufferLineGoToBuffer 3<CR>";
    }
    {
      mode = "n";
      key = "<C-4>";
      action = ":BufferLineGoToBuffer 4<CR>";
    }
    {
      mode = "n";
      key = "<C-5>";
      action = ":BufferLineGoToBuffer 5<CR>";
    }
    {
      mode = "n";
      key = "<C-S-h>";
      action = ":BufferLineMovePrev<CR>";
      options.desc = "Move buffer  ";
    }
    {
      mode = "n";
      key = "<C-S-l>";
      action = ":BufferLineMoveNext<CR>";
      options.desc = "Move buffer  ";
    }
  ];
}
