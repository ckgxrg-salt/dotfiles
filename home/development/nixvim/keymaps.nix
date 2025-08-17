{
  keymaps = [
    {
      mode = "n";
      key = "j";
      action = "gj";
    }
    {
      mode = "n";
      key = "k";
      action = "gk";
    }
    {
      mode = "n";
      key = "<Down>";
      action = "gj";
    }
    {
      mode = "n";
      key = "<Up>";
      action = "gk";
    }
    {
      mode = "n";
      key = "<C-w>";
      action = ":bdelete<CR>";
      options = {
        nowait = true;
        desc = "Close Current File";
      };
    }
  ];
}
