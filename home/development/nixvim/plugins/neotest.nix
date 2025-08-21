{
  plugins.neotest = {
    enable = true;
    settings = {
      adapters = [
        "require('rustaceanvim.neotest')"
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>rt";
      action.__raw = "function() require('neotest').run.run() end";
      options.desc = "Run nearest test";
    }
    {
      mode = "n";
      key = "<leader>rf";
      action.__raw = "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options.desc = "Run tests in this file";
    }
    {
      mode = "n";
      key = "<leader>rs";
      action.__raw = "function() require('neotest').summary.toggle() end";
      options.desc = "Show tests summary";
    }
    {
      mode = "n";
      key = "<leader>ro";
      action.__raw = "function() require('neotest').output.open({enter = true}) end";
      options.desc = "Show test output";
    }
  ];
}
