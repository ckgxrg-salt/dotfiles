{ lib, ... }:
{
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.lanzaboote.enable = lib.mkForce false;
  boot.initrd = {
    systemd.enable = true;
    verbose = false;
    availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [
      "kvm-intel"
    ];
  };
}
