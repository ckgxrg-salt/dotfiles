{ pkgs, ... }:
# Wrap some dangerous apps in Firejail
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      "qq" = {
        executable = "${pkgs.qq}/bin/qq";
        profile = "${pkgs.firejail}/etc/firejail/qq.profile";
      };
    };
  };
}
