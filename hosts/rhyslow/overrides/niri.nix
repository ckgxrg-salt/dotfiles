{ ... }:
{
  # Wonder why same monitor can have 2 names...
  xdg.configFile."niri/overrides.kdl".text = ''
    output "HDMI-A-1" {
        mode "2560x1440@143.999"
        scale 1
        focus-at-startup
    }
    output "HDMI-A-2" {
        mode "2560x1440@143.999"
        scale 1
        focus-at-startup
    }
  '';
}
