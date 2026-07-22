{
  osConfig,
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
  };

  config = mkIf cfg.enable {
    # TODO: matugen

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          fcitx5-mozc
        ];
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
            classicui.globalSection = {
              Font = "${osConfig.theme.fonts.name} ${toString osConfig.theme.fonts.sizes.popups}";
              MenuFont = "${osConfig.theme.fonts.name} ${toString osConfig.theme.fonts.sizes.popups}";
              TrayFont = "${osConfig.theme.fonts.name} ${toString osConfig.theme.fonts.sizes.popups}";
            };
          };
        };
      };
    };
  };
}
