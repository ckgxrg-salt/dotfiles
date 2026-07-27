{ ... }:
{
  xdg.configFile."niri/overrides.kdl".text = ''
    output "eDP-1" {
        mode "2880x1800@120.00"
        scale 1
        focus-at-startup
    }
  '';
}
