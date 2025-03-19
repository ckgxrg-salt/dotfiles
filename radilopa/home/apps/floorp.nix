{ pkgs, ... }:
# Floorp browser
{
  programs.floorp = {
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
          "ArchWiki" = {
            urls = [ { template = "https://wiki.archlinux.org/?search={searchTerms}"; } ];
            iconUpdateURL = "https://archlinux.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@aw" ];
          };
          "Nix Packages" = {
            urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@pkg" ];
          };
          "NixOS Options" = {
            urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@opt" ];
          };
          "Bilibili" = {
            urls = [ { template = "https://search.bilibili.com/all?keyword={searchTerms}"; } ];
            iconUpdateURL = "https://bilibili.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@bili" ];
          };
          "PRTS Wiki" = {
            urls = [ { template = "https://prts.wiki/index.php?title=特殊:搜索&search={searchTerms}"; } ];
            iconUpdateURL = "https://prts.wiki/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
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
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          absolute-enable-right-click
          dark-background-light-text
          disconnect
          firefox-color
          keepassxc-browser
        ];
        settings = {
          # Dark background light text
          "jid1-QoFqdK4qzUfGWQ@jetpack".settings = {
            default_background_color = "#3b4261";
            default_link_color = "#41a6b5";
            default_visited_color = "#9d7cd8";
            default_active_color = "#4fd6be";
            default_selection_color = "#c0caf5";
          };
        };
      };
    };
  };
}
