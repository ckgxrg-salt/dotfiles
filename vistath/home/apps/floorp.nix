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
          keepassxc-browser
          surfingkeys
          tokyo-night-v2
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

          # Surfingkeys
          "{a8332c60-5b6d-41ee-bfc8-e9bb331d34ad}".settings = {
            showAdvanced = true;
            snippets = ''
              // Disable unused functionalities
              api.unmapAllExcept([
                'af', 'E', 'R', 'T', 't', 'f',
                '?', '<Alt-i>',
                '0', 'e', 'U', 'd', 'P', 'gg', 'G', 'j', 'k', 'h', 'l', '$',
                'yt', 'x', 'X', '<<', '>>',
                'r', 'S', 'D',
                'yy', 'yv',
                'go', ':', '<Esc>', '<Tab>', '<Ctrl-n>', '<Ctrl-p>'
              ]);
              // Rebind some keys
              api.map('F', 'af');
              api.map('H', 'E');
              api.map('L', 'R');
              api.map('<Shift-Tab>', 'T');
              api.map('O', 't');
              settings.defaultSearchEngine = "b";
              // Rose-pine
              settings.theme = `
                .sk_theme {
                  background: #232136;
                  color: #e0def4;
                }
                .sk_bubble {
                  background: #232136;
                  color: #e0def4;
                }
                .sk_omnibar {
                  background: #232136;
                  color: #e0def4;
                }
              `
            '';
          };
        };
      };
    };
  };
}
