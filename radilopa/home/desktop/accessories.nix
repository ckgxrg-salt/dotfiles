{
  pkgs,
  ckgs,
  config,
  ...
}:
# Extra programs for Hyprland
{
  imports = [
    ./waybar.nix
    ./hypreco.nix
    ./wlogout.nix
  ];

  # Hyprland accessories
  home.packages = with pkgs; [
    waypaper
    swww
    udiskie
    blueberry
    networkmanagerapplet
    grimblast

    brightnessctl
    pamixer
    libnotify
    wl-clipboard

    libsForQt5.polkit-kde-agent

    playerctl
    pwvucontrol
  ];

  # Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    font = "Maple Mono 16";
    location = "top-right";
    plugins = with pkgs; [
      rofi-emoji-wayland
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-3/style-1.rasi";
    extraConfig = {
      show-icons = true;
      icon-theme = config.ckgxrg.themes.icon.name;
    };
  };

  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    anchor = "top-right";
    borderRadius = 15;
    defaultTimeout = 15000;
    font = "maple mono 12";
    height = 150;
    width = 450;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;

    iconPath = "${config.home.profileDirectory}/share/icons/${config.ckgxrg.themes.icon.name}";
  };

  # udiskie the Auto-Mount Manager, sadly Nix is problematic dealing with order of options
  xdg.configFile."udiskie/config.yml".text = ''
    program_options:
      automount: true
      notify: true
      tray: auto
  '';

  services.cliphist.enable = true;

  # Waypaper
  xdg.configFile."waypaper/config.ini".source =
    let
      iniFormat = pkgs.formats.ini { };
    in
    iniFormat.generate "waypaper.ini" {
      Settings = {
        folder = "${config.xdg.userDirs.pictures}";
        fill = "Fill";
        sort = "name";
        backend = "swww";
        color = "#ffffff";
        subfolders = true;
        monitors = "eDP-1";
      };
    };
}
