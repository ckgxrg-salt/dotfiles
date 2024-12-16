{
  pkgs,
  ckgs,
  config,
  ...
}:
# Extra desktop programs
{
  imports = [
    ./fcitx.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./waybar.nix
    ./wlogout.nix
    ./daemons.nix
  ];

  # Hyprland accessories
  home.packages = with pkgs; [
    waypaper
    grimblast

    brightnessctl
    swww
    playerctl

    pamixer
    libnotify

    wl-clipboard
    cliphist
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
      run-command = "uwsm app -- {cmd}";
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
  # Mako's icons
  xdg.configFile = {
    "mako/icons/brightness-20.png".source = ../../../../assets/brightness-20.png;
    "mako/icons/brightness-40.png".source = ../../../../assets/brightness-40.png;
    "mako/icons/brightness-60.png".source = ../../../../assets/brightness-60.png;
    "mako/icons/brightness-80.png".source = ../../../../assets/brightness-80.png;
    "mako/icons/brightness-100.png".source = ../../../../assets/brightness-100.png;
    "mako/icons/volume-high.png".source = ../../../../assets/volume-high.png;
    "mako/icons/volume-low.png".source = ../../../../assets/volume-low.png;
    "mako/icons/volume-mid.png".source = ../../../../assets/volume-mid.png;
    "mako/icons/volume-mute.png".source = ../../../../assets/volume-mute.png;
  };

  # udiskie the Auto-Mount Manager, sadly Nix is problematic dealing with order of options
  xdg.configFile."udiskie/config.yml".text = ''
    program_options:
      automount: true
      notify: true
      tray: auto
  '';

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
