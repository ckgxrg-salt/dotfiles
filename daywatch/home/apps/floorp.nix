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
          keepassxc-browser
          surfingkeys
        ];
        settings = {
          # Dark background light text
          "jid1-QoFqdK4qzUfGWQ@jetpack".settings = {
            default_background_color = "#2d353b";
            default_link_color = "#7fbbb3";
            default_visited_color = "#d699b6";
            default_active_color = "#d699b6";
            default_selection_color = "#a7c080";
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
              // "Disable" omnibar
              api.cmap('t', '!!!nope');
              api.cmap('go', '!!!nope');
              api.cmap('O', '!!!nope');
              // Everforest
              settings.theme = `
                .sk_theme {
                  background: #343F44;
                  color: #D3C6AA;
                }
                .sk_bubble {
                  background: #425047;
                  color: #D3C6AA;
                }
                .sk_omnibar {
                  background: #3A515D;
                  color: #D3C6AA;
                }
              `
            '';
          };
        };
      };
    };
  };
}
