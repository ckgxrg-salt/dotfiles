{ pkgs, ... }:
# KeepassXC password manager
{
  home.packages = with pkgs; [
    keepassxc
    keepmenu
    libsecret
  ];

  # As secret service
  xdg.portal.config = {
    common = {
      "org.freedesktop.impl.portal.Secret" = [ "keepassxc" ];
    };
    hyprland = {
      "org.freedesktop.impl.portal.Secret" = [ "keepassxc" ];
    };
  };

  # Float KeepassXC windows
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:(org.keepassxc.KeePassXC)"
  ];
}
