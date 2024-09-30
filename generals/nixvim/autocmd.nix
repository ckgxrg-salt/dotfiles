{ ... }:
{
  programs.nixvim.autoCmd = [
    {
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      command = "set number";
    }
  ];
}
