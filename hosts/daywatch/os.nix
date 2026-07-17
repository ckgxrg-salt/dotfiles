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
    u2f.enable = true;
  };
  misc = {
    default = true;
    locale.default = true;
    security.default = true;
  };
  virtualisation.waydroid.enable = true;
  program = {
    mihomo.enable = true;
    gamemode.enable = true;
    nix.enable = true;
    steam.enable = true;
    netbird.enable = true;
    tuned.enable = true;
    thermald.enable = true;
  };
  theme = {
    cursor = {
      name = "KrisCursor";
      size = 32;
    };
  };
  stylix = {
    default = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    polarity = "dark";
    icons = {
      enable = true;
      package = pkgs.vimix-icon-theme;
      dark = "Vimix-black-dark";
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
      lxgw-neoxihei
      ckgs.offside
      noto-fonts
      noto-fonts-cjk-sans

      nerd-fonts.iosevka
      twitter-color-emoji
      fira-math
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Offside"
        "LXGW Neo XiHei"
      ];
      serif = [
        "Offside"
        "LXGW Neo XiHei"
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
