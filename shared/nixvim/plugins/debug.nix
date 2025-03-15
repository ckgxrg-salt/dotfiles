{ pkgs, ... }:
{
  # nvim-dap for debugging
  programs.nixvim.extraPackages = with pkgs; [
    lldb
    fd
  ];
  programs.nixvim.plugins = {
    dap = {
      enable = true;
      # Signs
      signs = {
        dapBreakpoint.text = "󰺕";
        dapBreakpointCondition.text = "";
        dapBreakpointRejected.text = "";
        dapLogPoint.text = "󰣕";
        dapStopped.text = "󰆷";
      };
      # Adapters
      adapters.executables = {
        "lldb" = {
          command = "${pkgs.lldb}/bin/lldb-dap";
        };
      };
      # Debug profiles
      configurations = {
        "rust" = [
          {
            name = "Current Project";
            request = "launch";
            type = "lldb";
            cwd = "\${workspaceFolder}";
            program.__raw = ''
              function()
                return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.tolower(vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
              end
            '';
          }
          {
            name = "Attach to a Process...";
            request = "attach";
            type = "lldb";
            pid.__raw = "require('dap.utils').pick_process";
          }
          {
            name = "Choose a Program...";
            request = "launch";
            type = "lldb";
            cwd = "\${workspaceFolder}";
            program.__raw = ''
              function()
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                return coroutine.create(function(coro)
                  local opts = {};
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
        ];
      };
    };

    # User interface
    dap-ui = {
      enable = true;
    };

    # Show inline info
    dap-virtual-text = {
      enable = true;
      settings = {
        commented = true;
      };
    };
  };
}
