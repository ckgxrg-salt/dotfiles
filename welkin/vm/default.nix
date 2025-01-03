{ pkgs, ... }:
# Microvm Entrypoint
{
  microvm = {
    host.enable = true;

    vms = {
      # Miscellaneous services
      "everpivot" = {
        inherit pkgs;
        config = import ./everpivot;
      };

      # Gitlab
      #"gitlab" = {
      #  inherit pkgs;
      #  config = import ./gitlab;
      #};

      # Minecraft servers
      "goatfold" = {
        inherit pkgs;
        config = import ./goatfold;
      };
    };
  };
}
