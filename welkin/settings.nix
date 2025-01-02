{ ... }:
# Hardware related
{
  #========== Hardware ==========#
  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  #========== Network & Devices ==========#
  # Internet
  networking = {
    # Ethernet only
    wireless.enable = false;

    # Firewall
    firewall = {
      enable = true;
    };
  };

  #========== Power ==========#
  services.thermald.enable = true;

  #========== Nix ==========#
  nix = {
    channel.enable = false;
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  #========== Localisation ==========#
  # Timezone, Locale
  time.timeZone = "Asia/Shanghai";
  services.timesyncd.enable = false;
  services.openntpd.enable = true;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
  };

  #========== Miscellaneous ==========#
  # Who'll need this...
  programs.nano.enable = false;
  programs.command-not-found.enable = false;
  documentation.nixos.enable = false;
  services.speechd.enable = false;
}
