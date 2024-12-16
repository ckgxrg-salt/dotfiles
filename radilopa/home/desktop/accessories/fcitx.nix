{ pkgs, lib, ... }:
# Input Method
{
  # Fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-nord
      fcitx5-rime
    ];
  };
  # Add fcitx5 to GTK settings
  gtk = {
    gtk2.extraConfig = "gtk-im-module=\"fcitx\"";
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };

  # Override the service for UWSM
  systemd.user.services."fcitx5-daemon" = lib.mkForce {
    Unit = {
      Description = "Fcitx5 Input Method";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      Restart = "on-failure";
      Slice = "app-graphical.slice";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
