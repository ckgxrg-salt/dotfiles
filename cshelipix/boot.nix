{ pkgs, config, ... }:
{
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = 0;
      systemd-boot.enable = true;
    };
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "deus_ex";
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "plymouth.nolog"
      "reboot=pci"
      "acpi=noirq"
      "rotate=180"
      "snd_hda_intel.probe_mask=0x01"
      "mem_sleep_default=deep"
    ];
    # BBR Congestion Algorithm
    kernelModules = [
      "tcp_bbr"
    ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
      "vm.laptop_mode" = 5;
    };
    # Workaround for sound
    extraModprobeConfig = ''
      options snd_sof_hda_common hda_model=alc287-yoga9-bass-spk-pin
      options snd slots=snd-hda-intel
      options snd-sof-intel-hda-common hda_model=alc287-yoga9-bass-spk-pin
    '';
  };
}
