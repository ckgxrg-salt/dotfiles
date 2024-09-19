{ inputs, pkgs-howdy, ... }:
# Configurations for Howdy biological authentication
{
  # Use the nixpkgs-howdy modules instead
  disabledModules = [
    "security/pam.nix"
  ];
  imports = [
    "${inputs.howdy}/nixos/modules/security/pam.nix"
    "${inputs.howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"
    "${inputs.howdy}/nixos/modules/services/security/howdy/default.nix"
  ];

  # Howdy the face recoginiser
  services.howdy = {
    enable = true;
    package = pkgs-howdy.howdy;
    settings = {
      core = {
        detection_notice = true;
      };
      video = {
        device_path = "/dev/video0";
      };
    };
  };
}
