{ ... }:
{
  # Wonder why same monitor can have 2 names...
  xdg.configFile."niri/overrides.kdl".text = ''
    output "DP-1" {
        mode "1920x1080@120.000"
        scale 1
        focus-at-startup
    }

    binds {
        Mod+XF86AudioPlay allow-when-locked=true { spawn "toggle-sink"; }
        XF86PowerOff { spawn "wlogout"; }
    }
  '';
}
