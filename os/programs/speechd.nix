{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.speechd;
in
{
  options.program.speechd = {
    enable = mkEnableOption "Enable default speech-dispatcher settings";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      piper-tts
    ];

    services.speechd = {
      enable = true;
      config = ''
        AddModule "piper" "sd_generic" "piper.conf"
        DefaultModule piper
      '';
      modules = {
        piper = ''
          GenericDefaultCharSet "utf-8"
          GenericExecuteSynth "piper --model /etc/piper-voices/$VOICE \"$DATA\" -f - | pw-play -"

          AddVoice "zh-CN" "female1" "zh_CN-huayan-medium.onnx"
          AddVoice "en-GB" "male1" "en_GB-aru-medium.onnx"

          DefaultVoice "zh_CN-huayan-medium.onnx"
        '';
      };
    };
  };
}
