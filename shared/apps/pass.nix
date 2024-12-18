{ pkgs, config, ... }:
# pass the Unix password manager
{
  home.packages = with pkgs; [
    pass-wayland
    qtpass
    pass-git-helper
  ];
  home.sessionVariables = {
    PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/password-store";
  };
  services.pass-secret-service = {
    enable = true;
    storePath = "${config.home.homeDirectory}/.local/share/password-store";
  };
  programs.git.extraConfig = {
    credential.helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
  };
}
