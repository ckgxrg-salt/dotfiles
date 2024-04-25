{ pkgs, config, ... }:
{
    # My Name!
    networking.hostName = "Twirisa";

    # AppArmor MAC
    security.apparmor = {
        enable = true;
        enableCache = true;
    };
    services.dbus.apparmor = "enabled";

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
            noto-fonts
            noto-fonts-cjk
            noto-fonts-emoji
            source-han-sans
            source-han-serif
            source-code-pro
            hack-font
            jetbrains-mono
            wqy_zenhei
            wqy_microhei
            powerline-fonts
            font-awesome
            maple-mono
            maple-mono-NF
        ];
        fontconfig = {
            defaultFonts = {
                emoji = [ "Noto Color Emoji" ];
                monospace = [
                    "Maple Mono"
                    "Noto Sans Mono CJK SC"
                    "Sarasa Mono SC"
                    "DejaVu Sans Mono"
                ];
                sansSerif = [
                    "Maple Mono"
                    "Source Han Sans SC"
                    "DejaVu Sans"
                ];
                serif = [
                    "Maple Mono"
                    "Source Han Serif SC"
                    "DejaVu Serif"
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

    # SDDM Session Manager
    services.displayManager.sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        wayland.enable = true;
        theme = "chili";
    };

    # Polkit Authentication
    security.polkit.enable = true;

    # TLP the power saver
    services.tlp.enable = true;

    # Auto-Mount Backend
    services.udisks2.enable = true;

    # MPD daemon
    services.mpd = {
        enable = true;
        musicDirectory = "/home/ckgxrg/Music";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "PipeWire Output"
            }
        '';
    };
}
