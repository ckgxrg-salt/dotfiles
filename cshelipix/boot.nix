{ pkgs, lib, ... }: {
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = 0;
      systemd-boot.enable = lib.mkForce false;
    };
    # Setup Secure Boot
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    # Setup boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "colorful_loop";
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "noefi"
      "quiet"
      "lockdown=integrity"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      "reboot=pci"
      "acpi=noirq"
      "fbcon=rotate:2"
    ];
    kernelModules = [
      "tcp_bbr"
      "snd-hda-intel"
      "snd-pcm-oss"
      "snd-mixer-oss"
      "snd-seq-oss"
    ];
    # BBR Congestion Algorithm
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
      "vm.laptop_mode" = 5;
    };
    # Workaround for sound
    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
      options snd_hda_intel model=lenovo-spk-noise
      options snd_sof_hda_common hda_model=alc287-yoga9-bass-spk-pin
      options snd-sof-intel-hda-common hda_model=alc287-yoga9-bass-spk-pin
    '';
  };
}
