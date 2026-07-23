{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.speechd;
in
{
  options.program.speechd = {
    enable = lib.mkEnableOption "Enable default speech-dispatcher settings";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      piper-tts
    ];

    services.speechd.enable = true;
  };
}
