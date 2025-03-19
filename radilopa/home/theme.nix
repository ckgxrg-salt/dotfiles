{
  pkgs,
  ckgs,
  config,
  ...
}:
# Define theme names and pkgs here
{
  theme = {
    enable = true;

    gtk = {
      name = "rose-pine-moon";
      pkg = pkgs.rose-pine-gtk-theme;
    };

    qt = {
      name = "MoeDark";
      pkg = ckgs.moe-kvantum-theme;
    };

    cursor = {
      name = "BreezeX-RosePine-Linux";
      size = 24;
      pkg = pkgs.rose-pine-cursor;
    };

    icon = {
      name = "rose-pine-moon";
      pkg = pkgs.rose-pine-icon-theme;
    };

    sound = {
      enable = true;
      libcanberra = pkgs.libcanberra-gtk3;
      theme = "oxygen";
      package = pkgs.kdePackages.oxygen-sounds;
    };

    font = {
      name = "Jost*";
      size = 18;
    };

    wallpaper.lxwengd = {
      enable = true;
      package = ckgs.lxwengd;
      assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
    };
  };
}
