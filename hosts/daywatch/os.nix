# Daywatch OS entrypoint
{
  pkgs,
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
    greetd = {
      enable = true;
      autoLogin = true;
    };
    howdy.enable = true;
  };
  misc = {
    default = true;
    locale = {
      default = true;
      autoTimezone = true;
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
      jost
      noto-fonts-cjk-sans
      maple-mono.NF
      noto-fonts-color-emoji
      # Fallback fonts
      fira-math
      noto-fonts
      liberation_ttf
    ];
    fontconfig.defaultFonts = {
      sansSerif = [
        "Jost*"
        "Noto Sans CJK SC"
      ];
      serif = [
        "Liberation Serif"
        "Noto Sans CJK SC"
      ];
      monospace = [ "Maple Mono NF" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  imports = [
    ./overrides/boot.nix
    ./overrides/disko.nix
    ./overrides/touchscreen.nix
  ];
}
