{ ... }: {
  programs.nixvim.autoCmd = [
    {
      command = "echo 'Editing C/C++ File'";
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.c"
        "*.h"
      ];
    }
  ];
}