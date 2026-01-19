{ lib, ... }:
{
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.initrd = {
    systemd.enable = true;
    verbose = false;
    availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [
      "kvm-amd"
    ];
  };
}
