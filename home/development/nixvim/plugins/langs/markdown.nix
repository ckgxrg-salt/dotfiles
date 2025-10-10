{
  plugins = {
    markview = {
      enable = true;
      settings = {
        preview = {
          filetypes = [
            "markdown"
            "codecompanion"
          ];
          ignore_buftypes = [ ];
        };
      };
    };

    zk = {
      enable = true;
      settings = {
        picker = "telescope";
        picker_options.telescope.__raw = "require('telescope.themes').get_dropdown()";
      };
    };
  };

  extraFiles."after/ftplugin/markdown.lua".text = ''
    if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
      vim.keymap.set("n", "<leader>ni", ":ZkIndex<CR>", { desc = "Index notebook", buffer = true })
      vim.keymap.set("n", "<leader>nn", ":ZkNew<CR>", { desc = "New note", buffer = true })
      vim.keymap.set("n", "<leader>nN", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = "Elaborate selection on new note", buffer = true })
      vim.keymap.set("n", "<leader>nc", ":ZkCd<CR>", { desc = "Go to notebook root", buffer = true })
      vim.keymap.set("n", "<leader>ns", ":ZkNotes<CR>", { desc = "Select notes", buffer = true })
      vim.keymap.set("n", "<leader>nS", ":ZkBuffers<CR>", { desc = "Select open notes", buffer = true })
      vim.keymap.set("n", "<leader>nl", ":ZkLinks<CR>", { desc = "Show outbound links", buffer = true })
      vim.keymap.set("n", "<leader>nL", ":ZkBacklinks<CR>", { desc = "Show backlinks", buffer = true })
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>em";
      action = ":Markview toggle<CR>";
      options.desc = "Toggle Markdown view";
    }
  ];
}
