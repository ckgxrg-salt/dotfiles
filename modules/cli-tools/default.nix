{ config, pkgs, ... }:
{
    # GNU Privacy Guard
    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        pinentryPackage = pkgs.pinentry-qt;
    };

    # Git Version Control System
    programs.git = {
        enable = true;
        lfs.enable = true;
        userName = "ckgxrg-salt";
        userEmail = "ckgxrg@outlook.com";
    };
}
