{ pkgs, ... }:
# Wrap some dangerous apps in Firejail
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      "qq" = {
        executable = "${pkgs.qq}/bin/qq";
        profile = "/etc/firejail/qq.profile";
      };
    };
  };

  environment.etc."firejail/qq.profile".text = ''
    whitelist ''${HOME}/Pictures
    noblacklist ''${HOME}/Pictures
    whitelist ''${HOME}/Downloads

    include linuxqq.local
    include allow-bin-sh.inc
    include disable-shell.inc

    caps.drop all
    ignore apparmor
    noprinters

    nonewprivs
    noroot
    notv
    nou2f
    protocol unix,inet,inet6,netlink
    seccomp !chroot

    disable-mnt

    private-opt QQ
    private-tmp
    private-etc alsa,alternatives,ca-certificates,crypto-policies,fonts,group,host.conf,hostname,hosts,ld.so.cache,ld.so.preload,localtime,login.defs,machine-id,nsswitch.conf,os-release,passwd,pki,pulse,resolv.conf,ssl,xdg

    noblacklist ''${HOME}/.config/QQ
    noblacklist ''${HOME}/.config/tencent-qq
    noblacklist ''${HOME}/.mozilla

    mkdir ''${HOME}/.config/QQ

    whitelist ''${HOME}/.config/QQ

    whitelist ''${HOME}/.config/pulse

    whitelist ''${HOME}/.local/share/fonts
    read-only ''${HOME}/.local/share/fonts

    dbus-user filter
    dbus-user.talk org.freedesktop.Notifications
    dbus-user.talk org.freedesktop.portal.Desktop
    dbus-user.talk org.freedesktop.portal.Fcitx
    dbus-user.talk org.freedesktop.portal.IBus
    dbus-user.talk org.freedesktop.ScreenSaver
    dbus-user.talk org.gnome.Mutter.IdleMonitor
    dbus-user.talk org.kde.StatusNotifierWatcher
    dbus-user.talk org.mozilla.*
    ignore dbus-user none

    include electron.profile
  '';
}
