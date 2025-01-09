{ ... }:
# Gitlab
{
  services.gitlab = {
    enable = true;
    databaseName = "archiva";
    databaseUsername = "gitlab-db";
    user = "gitlab";
    group = "gitlab";
  };

  # Gitlab related users
  users = {
    users = {
      "gitlab" = {
        description = "Gitlab";
        isSystemUser = true;
        group = "gitlab";
      };
      "gitlab-db" = {
        description = "Gitlab Database";
        isSystemUser = true;
        group = "gitlab";
      };
    };
    groups = {
      "gitlab" = { };
    };
  };
}
