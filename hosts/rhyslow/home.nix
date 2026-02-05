# Rhyslow HM entrypoint
{
  pkgs,
  ckgs,
  ...
}:
{
  secrets.sops = true;
  program = {
    defaultPkgs = true;
    btop.enable = true;
    calendar.enable = true;
    contacts.enable = true;
    email = {
      enable = true;
      autoRefresh = true;
    };
    fcitx5.enable = true;
    floorp.enable = true;
    foliate.enable = true;
    git.enable = true;
    gopass.enable = true;
    gpg.enable = true;
    mangohud.enable = true;
    mpd.enable = true;
    vdirsyncer = {
      enable = true;
      autoUpdate = true;
    };
    vicinae.enable = true;
    yazi.enable = true;
  };
  home.packages = with pkgs; [
    nvitop
    blockbench
    blender
    gimp
    libreoffice
  ];
  daemons = {
    cliphist.enable = true;
    dunst.enable = true;
    udiskie.enable = true;
    polkit-gnome-agent.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    syncthing.enable = true;
  };
  development = {
    distrobox.enable = true;
    neovim.enable = true;
  };
  stylix = {
    default = true;
    icons = {
      enable = true;
      package = pkgs.dracula-icon-theme;
      dark = "Dracula";
    };
  };
  theme = {
    wallpaper = {
      # lxwengd = {
      #   enable = true;
      #   package = ckgs.lxwengd;
      #   assetsPath = "${config.xdg.dataHome}/Steam/steamprogram/common/wallpaper_engine/assets";
      # };
    };
  };
  desktop = {
    hyprland.enable = true;
    sessionVars.default = true;
    xdg.default = true;
  };
  terminal = {
    accessories.enable = true;
    alacritty.enable = true;
    bash.enable = true;
    direnv.enable = true;
    nushell.enable = true;
    starship.enable = true;
  };

  imports = [
    ./overrides/hyprland.nix
    ./overrides/waybar.nix
    ./overrides/wlogout.nix
  ];
}
