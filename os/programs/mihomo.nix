{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.mihomo;
in
{
  options.program.mihomo = {
    enable = mkEnableOption "Enable default Mihomo settings";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.mihomo
    ];

    users = {
      users = {
        "mihomo" = {
          isSystemUser = true;
          group = "mihomo";
        };
        "ckgxrg".extraGroups = [ "mihomo" ];
      };
      groups."mihomo" = { };
    };

    systemd.services."mihomo" = {
      description = "Mihomo daemon, A rule-based proxy in Go.";
      documentation = [ "https://wiki.metacubex.one/" ];
      requires = [ "network-online.target" ];
      after = [ "network-online.target" ];
      serviceConfig = {
        ExecStart = lib.concatStringsSep " " [
          (lib.getExe pkgs.mihomo)
          "-d /var/lib/mihomo"
          "-ext-ui ${pkgs.metacubexd}"
        ];

        User = "mihomo";
        Group = "mihomo";

        AmbientCapabilities = [
          "CAP_NET_ADMIN"
          "CAP_DAC_READ_SEARCH"
          "CAP_SYS_PTRACE"
        ];
        CapabilityBoundingSet = [
          "CAP_NET_ADMIN"
          "CAP_DAC_READ_SEARCH"
          "CAP_SYS_PTRACE"
        ];
        DeviceAllow = "";
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateMounts = true;
        PrivateTmp = true;
        ProcSubset = "pid";
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        ReadWritePaths = [ "/var/lib/mihomo" ];
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service bpf";
        PrivateDevices = false;
        PrivateUsers = false;
        RestrictAddressFamilies = "AF_INET AF_INET6 AF_NETLINK";
        UMask = "0007";
      };
    };
  };
}
