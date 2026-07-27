{ config, lib, ... }:
let
  cfg = config.secrets.sops;
in
{
  options.secrets.sops = lib.mkEnableOption "Enable default sops secrets";

  config = lib.mkIf cfg {
    sops = {
      defaultSopsFile = ./default.yaml;
      age.keyFile = "/home/ckgxrg/.config/sops/age/keys.txt";
      secrets = {
        "gmail-oauth" = { };
        "welkin-passwd" = { };
      };
    };
  };
}
