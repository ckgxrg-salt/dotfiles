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
      key = "<Leader>rr";
      action.__raw = "function() require('neotest').run.run() end";
      options.desc = "Run nearest test";
    }
    {
      mode = "n";
      key = "<Leader>rf";
      action.__raw = "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options.desc = "Run tests in this file";
    }
    {
      mode = "n";
      key = "<Leader>rs";
      action.__raw = "function() require('neotest').summary.toggle() end";
      options.desc = "Show tests summary";
    }
    {
      mode = "n";
      key = "<Leader>ro";
      action.__raw = "function() require('neotest').output.open({enter = true}) end";
      options.desc = "Show test output";
    }
  ];
}
