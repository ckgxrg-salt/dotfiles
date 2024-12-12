{ pkgs, lib, ... }:
{
  # SDDM Session Manager
  environment.systemPackages = with pkgs; [ sddm-astronaut ];
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      breeze-icons
      kirigami
      plasma5support
      qtsvg
      qtvirtualkeyboard
    ];
  };

  # Universal Wayland Session Manager
  programs.uwsm = {
    enable = true;
    waylandCompositors = lib.mkForce {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland Session";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
}
