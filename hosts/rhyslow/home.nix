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
    git.enable = true;
    gopass.enable = true;
    gpg.enable = true;
    lutris.enable = true;
    mangohud.enable = true;
    mpd.enable = true;
    rofi = {
      enable = true;
      theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-3/style-1.rasi";
    };
    vdirsyncer = {
      enable = true;
      autoUpdate = true;
    };
    yazi.enable = true;
    zk.enable = true;
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
    nm-applet.enable = true;
    udiskie.enable = true;
    polkit-gnome-agent.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    mako.enable = true;
    syncthing.enable = true;
  };
  development = {
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
    nushell = {
      enable = true;
      settings = ''
        $env.LS_COLORS = (vivid generate iceberg-dark | str trim)
      '';
    };
    starship.enable = true;
  };

  imports = [
    ./overrides/hyprland.nix
    ./overrides/waybar.nix
    ./overrides/wlogout.nix
  ];
}
