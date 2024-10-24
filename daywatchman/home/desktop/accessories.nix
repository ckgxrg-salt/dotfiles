{ pkgs, config, ... }:
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

    libsForQt5.polkit-kde-agent

    playerctl
    pwvucontrol

    nwg-drawer
  ];

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
    "mako/icons/brightness-20.png".source = ../../../assets/brightness-20.png;
    "mako/icons/brightness-40.png".source = ../../../assets/brightness-40.png;
    "mako/icons/brightness-60.png".source = ../../../assets/brightness-60.png;
    "mako/icons/brightness-80.png".source = ../../../assets/brightness-80.png;
    "mako/icons/brightness-100.png".source = ../../../assets/brightness-100.png;
    "mako/icons/volume-high.png".source = ../../../assets/volume-high.png;
    "mako/icons/volume-low.png".source = ../../../assets/volume-low.png;
    "mako/icons/volume-mid.png".source = ../../../assets/volume-mid.png;
    "mako/icons/volume-mute.png".source = ../../../assets/volume-mute.png;
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

  services.cliphist = {
    enable = true;
  };

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

  # Redshift the color temperature adjuster
  services.redshift = {
    enable = true;
    longitude = 117.0702181;
    latitude = 36.6663163;
    tray = false;
    temperature = {
      day = 5000;
      night = 3200;
    };
    settings = {
      redshift = {
        fade = 1;
      };
    };
  };
}
