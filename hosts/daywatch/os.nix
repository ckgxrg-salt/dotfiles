# Daywatch OS entrypoint
{
  pkgs,
  ckgs,
  ...
}:
{
  device = {
    hostname = "Daywatch";
    laptop = true;
    hostCPU = "intel";
    hostGPU = "intel";
    version = "25.11";
  };
  boot = {
    default = true;
    limine.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
    bbr = true;
    noCoredump = true;
    splash = "loader_2";
  };
  hardware = {
    default = true;
    btrfs = true;
    wifi = true;
    bt = true;
  };
  login = {
    users.default = true;
    greetd.enable = true;
    howdy.enable = true;
  };
  misc = {
    default = true;
    locale = {
      default = true;
      timezone = "Etc/GMT";
    };
    security.default = true;
  };
  virtualisation.waydroid.enable = true;
  program = {
    gamemode.enable = true;
    nix.enable = true;
    steam.enable = true;
    tailscale.enable = true;
    tuned.enable = true;
    thermald.enable = true;
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nebula.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 28;
    };
    fonts.sizes = {
      applications = 24;
      desktop = 24;
      popups = 20;
      terminal = 20;
    };
  };
  fonts = {
    packages = with pkgs; [
      maple-mono.opentype
      ckgs.lxgw-marker-gothic
      ckgs.offside

      nerd-fonts.iosevka
      twitter-color-emoji
      fira-math
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Offside"
        "LXGW Marker Gothic"
      ];
      serif = [
        "Offside"
        "LXGW Marker Gothic"
      ];
      monospace = [
        "Maple Mono"
      ];
      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/touchscreen.nix
  ];
}
