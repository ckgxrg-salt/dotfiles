{ ... }:
# Thunderbird
{
  programs.thunderbird = {
    enable = true;
    profiles = {
      "default" = {
        isDefault = true;
        search = {
          default = "Bing";
        };
      };
    };
    settings = {
      "general.useragent.override" = "";
      "privacy.donottrackheader.enabled" = true;
    };
  };
}
