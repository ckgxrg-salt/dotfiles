{ pkgs, inputs, config, ... }:
{
  # Strange messages
  environment.etc."issue".text = ''
               \\
                \\
    ========     ||
                 ||
    ========     ||
                //
               //
  '';
  environment.etc."motd".text = ''
    ===========================
    <-- The Daywardens Site -->
    ===========================
  '';

  # ckgxrg's Account
  users.users.ckgxrg = {
    isNormalUser = true;
    description = "ckgxrg";
    shell = pkgs.nushell;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "gamemode"
      "video"
    ];
  };

  # Greetd Session Manager
  environment.systemPackages = [ pkgs.greetd.wlgreet ];
  services.greetd = let 
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
      exec-once = wlgreet --command Hyprland; hyprctl dispatch exit
    '';
  in {
    enable = true;
    vt = 7;
    settings = {
      initial_session = {
        command = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "ckgxrg";
      };
      default_session = {
        command = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland -c ${hyprConfig}";
        user = "greeter";
      };
    };
  };
}
