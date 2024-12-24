{ pkgs, ... }:
# Bootup Process
{
  imports = [ ./fstab.nix ];
  boot = {
    #========== Bootloader ==========#
    # Config GRUB
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
      };
    };

    #========== Initrd ==========#
    initrd = {
      # Use systemd instead of busybox
      systemd.enable = true;
      verbose = true;
    };

    #========== Kernel ==========#
    # Use Liquorix kernel
    kernelPackages = pkgs.linuxPackages_lqx;

    # Kernel params
    kernelParams = [
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
    ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };

}
