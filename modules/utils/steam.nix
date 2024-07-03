{ pkgs, ... }: {
  # Steam and Gamescope Settings
  programs.steam = {
    enable = true;
    fontPackages = with pkgs; [ source-han-sans ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = true;
      args = [ "-O eDP-1" ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
