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
        default = "bing";
        force = true;
        order = [
          "bing"
          "google"
        ];
        engines = {
          bing.metaData.alias = "@b";
          google.metaData.alias = "@g";
          archwiki = {
            name = "ArchWiki";
            urls = [ { template = "https://wiki.archlinux.org/?search={searchTerms}"; } ];
            icon = "https://archlinux.org/favicon.png";
            definedAliases = [ "@aw" ];
          };
          nixpkgs = {
            name = "Nix Packages";
            urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
            icon = "https://nixos.org/favicon.png";
            definedAliases = [ "@pkg" ];
          };
          nixopts = {
            name = "NixOS Options";
            urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
            icon = "https://nixos.org/favicon.png";
            definedAliases = [ "@opt" ];
          };
          crates = {
            name = "Rust Crates";
            urls = [ { template = "https://crates.io/search?q={searchTerms}"; } ];
            icon = "https://crates.io/favicon.png";
            definedAliases = [ "@rust" ];
          };
          bili = {
            name = "Bilibili";
            urls = [ { template = "https://search.bilibili.com/all?keyword={searchTerms}"; } ];
            icon = "https://bilibili.com/favicon.ico";
            definedAliases = [ "@bili" ];
          };
          prts = {
            name = "PRTS Wiki";
            urls = [ { template = "https://prts.wiki/index.php?title=特殊:搜索&search={searchTerms}"; } ];
            icon = "https://prts.wiki/favicon.ico";
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
