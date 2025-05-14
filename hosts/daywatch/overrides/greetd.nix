{ pkgs, lib, ... }:
{
  services.greetd =
    let
      # Need to handle multi-screen
      hyprConfig = pkgs.writeText "regreet-hyprland" ''
        monitor=eDP-1,preferred,auto,1
        monitor=DP-1,disabled
        device {
          name = elan9008:00-04f3:2d55
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b
          enabled = false
        }
        device {
          name = elan9008:00-04f3:2d55-stylus
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b-stylus
          enabled = false
        }
        misc {
          disable_hyprland_logo = true
          disable_hyprland_qtutils_check = true
        }
        animations {
          enabled = false
        }
        exec-once = ${lib.getExe pkgs.greetd.regreet}; hyprctl dispatch exit
      '';
    in
    {
      settings = {
        default_session.command = lib.mkForce "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.hyprland} -c ${hyprConfig}";
      };
    };
}
