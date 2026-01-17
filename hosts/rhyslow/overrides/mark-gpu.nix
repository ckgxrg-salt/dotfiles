{ ... }:
{
  # Mark the integrated GPU for Hyprland to identify
  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:0c:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/amd-igpu"
  '';
}
