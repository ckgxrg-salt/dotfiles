{ ... }:
{
  # Wonder why same monitor can have 2 names...
  xdg.configFile."niri/overrides.kdl".text = ''
    output "DP-1" {
        mode "2560x1440@144.001"
        scale 1
        focus-at-startup
    }

    debug {
        ignore-drm-device "/dev/dri/nvidia-gpu"
    }

    binds {
        Mod+XF86AudioPlay allow-when-locked=true { spawn "toggle-sink"; }
    }
  '';
}
