{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.fcitx5;
in
{
  options.program.fcitx5 = {
    enable = mkEnableOption "Enable Fcitx5 input method";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of extra fcitx5 plugins";
    };
  };

  config = mkIf cfg.enable {
    stylix.targets.fcitx5.enable = true;

    xdg.dataFile."fcitx5/rime/default.custom.yaml".text = ''
      patch:
        __include: rime_ice_suggestion:/
    '';

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons =
          with pkgs;
          [
            fcitx5-mozc

            (fcitx5-rime.override {
              rimeDataPkgs = [
                rime-ice
                rime-zhwiki
                rime-moegirl
              ];
            })
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
            "Groups/0/Items/2".Name = "mozc";
          };

          globalOptions = {
            Hotkey = {
              AltTriggerKeys = "";
            };
            "Hotkey/TriggerKeys"."0" = "Control+space";
          };

          addons = {
            clipboard.globalSection = {
              # Disable
              TriggerKey = "";
            };
          };
        };
      };
    };
  };
}
