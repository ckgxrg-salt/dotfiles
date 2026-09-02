{
  config,
  lib,
  ckgs,
  ...
}:
let
  cfg = config.desktop.dwsh;
in
{
  options.desktop.dwsh = {
    enable = lib.mkEnableOption "Enable dwsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ ckgs.dwsh ];

    systemd.user = {
      services = {
        "dwsh" = {
          Unit = {
            Description = "Daywatch Desktop Shell";
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "exec";
            ExecStart = "${ckgs.dwsh}/bin/dwsh";
            Restart = "on-failure";
            Environment = "FORTUNE_DIR=${config.home.homeDirectory}/.local/share/fortune";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
