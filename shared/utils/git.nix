{ ... }:
# Git VCS
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "ckgxrg";
    userEmail = "ckgxrg@ckgxrg.io";
    extraConfig = {
      pull.rebase = true;
      commit.gpgsign = true;
    };
  };
}
