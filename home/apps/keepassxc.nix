{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.keepassxc;
in
{
  options.apps.keepassxc = mkEnableOption "Enable KeepassXC password manager";

  config = mkIf cfg {
    home.packages = with pkgs; [
      keepassxc
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
  };
}
