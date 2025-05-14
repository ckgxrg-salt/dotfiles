{ ... }:
{
  boot.initrd = {
    systemd.enable = true;
    verbose = false;
    availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_usb_sdmmc"
    ];
    kernelModules = [
      "kvm-intel"
      "i915"
    ];
  };
}
