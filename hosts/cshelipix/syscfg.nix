{ pkgs, config, ... }:
# System-wide settings for Cshelipix
{
    # My Name!
    networking.hostName = "Cshelipix";

    # AppArmor MAC
    security.apparmor = {
        enable = true;
        enableCache = true;
    };
    services.dbus.apparmor = "enabled";

    # Power Button Behaviour
    services.logind = {
        powerKey = "lock";
        powerKeyLongPress = "poweroff";
        lidSwitch = "suspend";
        lidSwitchExternalPower = "suspend";
        lidSwitchDocked = "ignore";
    };
    services.systemd-lock-handler.enable = true;

    # Network with NetworkManager
    networking.networkmanager.enable = true;

    # Sound with PipeWire
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # ckgxrg's Account
    users.users.ckgxrg = {
        isNormalUser = true;
        description = "ckgxrg";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Locale, I18n and Fcitx5
    time.timeZone = "Asia/Shanghai";
    i18n = {
        defaultLocale = "en_GB.UTF-8";
        supportedLocales = ["zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8"];
        extraLocaleSettings = {
            LC_ADDRESS = "en_US.UTF-8";
            LC_IDENTIFICATION = "en_US.UTF-8";
            LC_MEASUREMENT = "en_US.UTF-8";
            LC_MONETARY = "en_US.UTF-8";
            LC_NAME = "en_US.UTF-8";
            LC_NUMERIC = "en_US.UTF-8";
            LC_PAPER = "en_US.UTF-8";
            LC_TELEPHONE = "en_US.UTF-8";
            LC_TIME = "en_US.UTF-8";
        };
    };

    # System Fonts
    fonts = {
        fontDir.enable = true;
        packages = with pkgs; [
            noto-fonts-emoji
            noto-fonts-cjk
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            powerline-fonts
            nerdfonts
            wqy_zenhei
            wqy_microhei
            maple-mono
        ];
        fontconfig = {
            defaultFonts = {
                emoji = [ "Noto Color Emoji" ];
                monospace = [
                    "Maple Mono"
                    "Noto Sans Mono CJK SC"
                ];
                sansSerif = [
                    "Maple Mono"
                    "Noto Sans CJK SC"
                ];
                serif = [
                    "Maple Mono"
                    "Noto Serif CJK SC"
                ];
            };
        };
    };

    # Proxychains
    programs.proxychains = {
        enable = true;
        package = pkgs.proxychains;
        proxies = {
        v2raya = {
            type = "socks5";
            host = "127.0.0.1";
            port = 20170;
        };
        };
    };

    # SDDM Session Manager & Gnome Keyring
    environment.systemPackages = [ pkgs.sddm-chili-theme ];
    security.pam.services.sddm.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services.hyprlock = {};
    services.displayManager.sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        wayland.enable = true;
        theme = "chili";
    };

    # Polkit Authentication
    security.polkit.enable = true;
    # TLP the power saver
    services.tlp = {
        enable = true;
        settings = {
            BAY_POWEROFF_ON_BAT = 1;
        };
    };
    # Violent Power Save
    powerManagement = {
        enable = true;
        powertop.enable = true;
        cpuFreqGovernor = "ondemand";
    };
    # Auto-Mount Backend
    services.udisks2.enable = true;
    # Nix-ld
    programs.nix-ld.enable = true;
    # Waydroid Emulator
    virtualisation.waydroid.enable = true;

    # MPD daemon
    services.mpd = {
        enable = true;
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "PipeWire Output"
            }
        '';
    };
}
