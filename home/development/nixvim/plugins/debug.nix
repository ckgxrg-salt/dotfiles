pkgs: {
  extraPackages = with pkgs; [
    lldb
    fd
  ];
  plugins = {
    dap = {
      enable = true;
      signs = {
        dapBreakpoint.text = "󰺕 ";
        dapBreakpointCondition.text = " ";
        dapBreakpointRejected.text = " ";
        dapLogPoint.text = "󰣕 ";
        dapStopped.text = "󰆷 ";
      };
      adapters.executables = {
        "lldb" = {
          command = "${pkgs.lldb}/bin/lldb-dap";
        };
      };
      configurations = {
        "rust" = [
          {
            name = "Launch an executable";
            type = "lldb";
            request = "launch";
            cwd = "\${workspaceFolder}";
            program.__raw = ''
              function()
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                return coroutine.create(function(coro)
                  local opts = {}
                  pickers
                    .new(opts, {
                      prompt_title = "Path to executable",
                      finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                      sorter = conf.generic_sorter(opts),
                      attach_mappings = function(buffer_number)
                        actions.select_default:replace(function()
                          actions.close(buffer_number)
                          coroutine.resume(coro, action_state.get_selected_entry()[1])
                        end)
                        return true
                      end,
                    })
                    :find()
                end)
              end
            '';
          }
          {
            name = "Select and attach to process";
            type = "lldb";
            request = "attach";
            program.__raw = ''
              function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end
            '';
            pid.__raw = ''
              function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
              end
            '';
            cwd = "\${workspaceFolder}";
          }
        ];
      };
    };

    dap-view = {
      enable = true;
      settings = {
        winbar = {
          default_section = "breakpoints";
        };
      };
    };

    dap-virtual-text = {
      enable = true;
      settings = {
        commented = true;
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<Leader>du";
      action = ":DapViewToggle<CR>";
      options.desc = "Toggle debug view";
    }
    {
      mode = "n";
      key = "<Leader>db";
      action = ":DapToggleBreakpoint<CR>";
      options.desc = "Add/Remove breakpoint";
    }
    {
      mode = "n";
      key = "<Leader>dc";
      action = ":DapContinue<CR>";
      options.desc = "Start/Continue debug";
    }
    {
      mode = "n";
      key = "<Leader>ds";
      action = ":DapStepOver<CR>";
      options.desc = "Step over";
    }
    {
      mode = "n";
      key = "<Leader>di";
      action = ":DapStepInto<CR>";
      options.desc = "Step into";
    }
    {
      mode = "n";
      key = "<Leader>do";
      action = ":DapStepOut<CR>";
      options.desc = "Step out";
    }
  ];
}
