{ pkgs, ... }:
{
  config = {
    xdg = {
      enable = true;
      mime.enable = true;

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config = {
          common = {
            default = [
              "gtk"
              "gnome"
            ];
          };
        };
      };

      userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = false;
      };
    };
  };
}
