{ ... }: {
  programs.nixvim.keymaps = [
    {
      action = "<cmd>make<CR>";
      key = "<C-m>";
      options = {
        silent = true;
      };
    }
  ];
}