pkgs: {
  extraPackages = with pkgs; [
    lldb
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
    };

    dap-ui = {
      enable = true;
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
      action = ":lua require('dapui').toggle()<CR>";
      options.desc = "Toggle Debug View";
    }
    {
      mode = "n";
      key = "<Leader>db";
      action = ":DapToggleBreakpoint<CR>";
      options.desc = "Add/Remove Breakpoint";
    }
    {
      mode = "n";
      key = "<Leader>dc";
      action = ":DapContinue<CR>";
      options.desc = "Continue Debug";
    }
    {
      mode = "n";
      key = "<Leader>ds";
      action = ":DapStepOver<CR>";
      options.desc = "Step Over";
    }
    {
      mode = "n";
      key = "<Leader>di";
      action = ":DapStepInto<CR>";
      options.desc = "Step Into";
    }
    {
      mode = "n";
      key = "<Leader>do";
      action = ":DapStepOut<CR>";
      options.desc = "Step Out";
    }
  ];
}
