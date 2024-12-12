{
  pkgs,
  ckgs,
  ...
}:
{
  # Greetd Session Manager
  environment.systemPackages = [ ckgs.qtgreet ];
  services.greetd =
    let
      hyprConfig = pkgs.writeText "greetd-hyprland-config" ''
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
        }
        animations {
          enabled = false
        }
        exec-once = qtgreet --data-path /var/lib/qtgreet; hyprctl dispatch exit
      '';
    in
    {
      enable = true;
      vt = 7;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "ckgxrg";
        };
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland -c ${hyprConfig}";
          user = "greeter";
        };
      };
    };
  # QtGreet Config
  environment.etc."qtgreet/config.ini".source =
    let
      iniFormat = pkgs.formats.ini { };
    in
    iniFormat.generate "qtgreet.ini" {
      General = {
        Backend = "GreetD";
        Theme = "aerial";
        BlurBackground = true;
        IconTheme = "breeze";
      };
      Overrides = {
        Background = "Tree.svg";
        BaseColor = "Theme";
        TextColor = "Theme";
        FontFamily = "Maple UI";
      };
      PowerCommands = {
        Suspend = "dbus";
        Hibernate = "dbus";
        Shutdown = "dbus";
        Reboot = "dbus";
      };
    };
  # Authorise QtGreet's datadir
  systemd.tmpfiles.rules = [
    "d /var/lib/qtgreet 0755 greeter greeter - -"
  ];
}
