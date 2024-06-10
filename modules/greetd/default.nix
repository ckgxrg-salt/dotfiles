{ pkgs, config, inputs, ... }:
{
  # Greetd Session Manager
  environment.systemPackages = with pkgs; [
    greetd.regreet
  ];
  services.greetd = 
  let
    hyprConfig = pkgs.writeText "greetd-hyprland-config" ''
      exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
      monitor = eDP-1, highres, 0x0, 1.25, transform, 2
      monitor = eDP-2, highres, 0x1800, 1.25
      animations {
        enabled = false
      }
      misc {
        disable_hyprland_logo = true
        background_color = 0x2e3440
      }
    '';
  in {
    enable = true;
    settings = {
      initial_session = {
        command = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "ckgxrg";
      };
      default_session = {
        command = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland --config ${hyprConfig}";
      };
    };
  };
}