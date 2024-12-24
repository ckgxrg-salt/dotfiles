{
  pkgs,
  ckgs,
  config,
  lib,
  ...
}:
# Extra programs for desktop environment
{
  imports = [
    ./daemons.nix
    ./fcitx.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./waybar.nix
    ./wlogout.nix
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
    font = "Maple UI 16";
    location = "top-right";
    plugins = with pkgs; [
      rofi-emoji-wayland
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-2/style-4.rasi";
    extraConfig = {
      show-icons = true;
      icon-theme = config.ckgxrg.themes.icon.name;
      run-command = "uwsm app -- {cmd}";
    };
  };

  # Mako vs Alien
  services.mako = {
    enable = true;
    output = "DP-1";
    anchor = "bottom-right";
    borderRadius = 0;
    backgroundColor = "#8fbcbb66";
    borderColor = "#4c566a66";
    defaultTimeout = 15000;
    font = "maple mono 12";
    height = 150;
    width = 450;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;

    iconPath = "${config.home.profileDirectory}/share/icons/${config.ckgxrg.themes.icon.name}";

    extraConfig = ''
      on-notify=exec canberra-gtk-play -i dialog-information -d "makoNotification"
      [urgency=low]
      on-notify=exec canberra-gtk-play -i dialog-question -d "makoNotification"
      [urgency=normal]
      on-notify=exec canberra-gtk-play -i dialog-information -d "makoNotification"
      [urgency=critical]
      on-notify=exec canberra-gtk-play -i dialog-error-critical -d "makoNotification";
    '';
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
    device_config:
    - device_file: /dev/loop0
      ignore: true
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
        folder = "${config.xdg.userDirs.pictures}/Wallpapers";
        fill = "Fill";
        sort = "name";
        backend = "swww";
        color = "#ffffff";
        subfolders = true;
        monitors = "eDP-1";
      };
    };

  # Gammastep the color temperature adjuster
  services.gammastep = {
    enable = true;
    tray = false;

    # Current position
    longitude = 117.1;
    latitude = 36.7;
    provider = "manual";

    temperature = {
      day = 6500;
      night = 5500;
    };

    settings = {
      general = {
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
  # ...and because of UWSM we again need to overwrite the systemd service
  systemd.user.services."gammastep" = {
    Unit = {
      PartOf = lib.mkForce [ ];
      After = lib.mkForce [ "graphical-session.target" ];
    };
    Service = {
      Slice = lib.mkForce "background-graphical.slice";
    };
  };

  # TODO: Battery warnings
  services.cbatticon = {
    enable = false;
    commandCriticalLevel = "notify-send -i battery 'Low Battery' 'Only 5% Battery Remaining'";
  };
}
