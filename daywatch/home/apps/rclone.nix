{ ... }:
# Syncs files from Nextcloud
{
  programs.rclone = {
    enable = true;
    remotes = {
      paralace = {
        config = {
          type = "webdav";
          url = "https://paralace.ckgxrg.io/remote.php/dav/files/ckgxrg";
          vendor = "nextcloud";
          user = "ckgxrg";
        };
        secrets = {
          pass = "/run/system-keys/paralace-passwd";
        };
      };
    };
  };
}
