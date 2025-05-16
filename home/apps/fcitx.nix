{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.apps.fcitx5;
in
{
  options.apps.fcitx5 = {
    enable = mkEnableOption "Enable Fcitx5 input method";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of extra fcitx5 plugins";
    };
  };

  config = mkIf cfg.enable {
    stylix.targets.fcitx5.enable = true;

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons =
          with pkgs;
          [
            fcitx5-rime
            fcitx5-mozc-ut
          ]
          ++ cfg.extraPackages;
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "rime";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "rime";
          };
        };
      };
    };

    # Add fcitx5 to GTK settings
    gtk = {
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
  };
}
