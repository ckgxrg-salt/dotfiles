{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.program.pi-agent;
in
{
  options.program.pi-agent = {
    enable = lib.mkEnableOption "Enable Pi coding agent";
  };

  config = lib.mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = true;
      configDir = "${config.xdg.configHome}/pi";
      mutableSettings = true;
      extraPackages = with pkgs; [
        nodejs
        pandoc
      ];
      settings = {
        tuiMode = "fullscreen";
        theme = "dark";
        packages = [
          "npm:pi-verdict"
          "npm:pi-web-access"
          "npm:pi-markdown-preview"
          "npm:pi-docparser"
        ];
      };
    };
  };
}
