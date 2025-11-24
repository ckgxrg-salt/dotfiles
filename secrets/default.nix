{ config, lib, ... }:
with lib;
let
  cfg = config.secrets.sops;
in
{
  options.secrets.sops = mkEnableOption "Enable default sops secrets";

  config = mkIf cfg {
    sops = {
      defaultSopsFile = ./default.yaml;
      age.keyFile = "/home/ckgxrg/.config/sops/age/keys.txt";
      secrets = {
        "gmail-oauth" = { };
        "welkin-passwd" = { };
        "gemini-token" = { };
      };
    };
  };
}
