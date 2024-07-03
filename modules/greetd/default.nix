{ pkgs, inputs, ... }: {
  # Greetd Session Manager
  environment.systemPackages = with pkgs.greetd; [ tuigreet ];
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      initial_session = {
        command =
          "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "ckgxrg";
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -g \"Hello again\" --power-shutdown 'systemctl reboot' -r
        --cmd ${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "greeter";
      };
    };
  };
}