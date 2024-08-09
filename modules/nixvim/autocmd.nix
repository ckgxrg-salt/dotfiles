{ ... }: {
  programs.nixvim.autoCmd = [
    {
      command = "echo ' '";
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.c"
        "*.h"
        "*.cpp"
        "*.hpp"
      ];
    }
    {
      command = "echo '󱄅 '";
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.nix"
      ];
    }
    {
      command = "echo ' '";
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.java"
      ];
    }
  ];
}