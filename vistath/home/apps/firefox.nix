{ pkgs, ... }:
# Firefox browser
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DNSOverHTTPS.Enabled = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
    profiles."default" = {
      isDefault = true;
      name = "Default";
      search = {
        default = "Bing";
        force = true;
        order = [
          "Bing"
          "Google"
        ];
        engines = {
          "Bing".metaData.alias = "@b";
          "Google".metaData.alias = "@g";
          "Nix Packages" = {
            urls = [ { template = "https://search.nixos.org/packages?channel=unstable?query={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.org/favicon.png";
            definedAliases = [ "@pkg" ];
          };
          "NixOS Options" = {
            urls = [ { template = "https://search.nixos.org/options?channel=unstable?query={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.org/favicon.png";
            definedAliases = [ "@opt" ];
          };
          "Bilibili" = {
            urls = [ { template = "https://search.bilibili.com/all?keyword={searchTerms}"; } ];
            iconUpdateURL = "https://bilibili.com/favicon.ico";
            definedAliases = [ "@bili" ];
          };
          "PRTS Wiki" = {
            urls = [ { template = "https://prts.wiki/index.php?title=特殊:搜索&search={searchTerms}"; } ];
            iconUpdateURL = "https://prts.wiki/favicon.ico";
            definedAliases = [ "@prts" ];
          };
        };
      };
      settings = {
        "browser.startup.homepage" = "about:blank";
        "dom.security.https_only_mode" = true;
        "browser.newtabpage.pinned" = [
          {
            title = "New Tab";
            url = "about:blank";
          }
        ];
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          absolute-enable-right-click
          browserpass
          dark-background-light-text
          disconnect
          firefox-color
        ];
        settings = {
          # Dark background light text
          "jid1-QoFqdK4qzUfGWQ@jetpack".settings = {
            default_background_color = "#232136";
            default_link_color = "#9ccfd8";
            default_visited_color = "#c4a7e7";
            default_active_color = "#ea9a97";
            default_selection_color = "#44415a";
          };
        };
      };
    };
  };

  # Read the pass store
  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };
}
