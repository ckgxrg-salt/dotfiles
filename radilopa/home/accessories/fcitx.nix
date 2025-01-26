{ pkgs, lib, ... }:
# Input Method
{
  # Fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
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
  systemd.user.services."fcitx5-daemon" = {
    Unit = {
      Description = lib.mkForce "Fcitx5 Input Method";
      PartOf = lib.mkForce [ ];
      After = lib.mkForce [ "graphical-session.target" ];
    };
    Service = {
      Type = "exec";
      Restart = "on-failure";
      Slice = "app-graphical.slice";
    };
  };
}
