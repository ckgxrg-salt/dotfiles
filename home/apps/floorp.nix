{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.floorp;
in
{
  options.apps.floorp = {
    enable = mkEnableOption "Enable Floorp web browser";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of extra Floorp extensions";
    };
  };

  config = mkIf cfg.enable {
    stylix.targets.floorp = {
      enable = true;
      colorTheme.enable = true;
      profileNames = [ "default" ];
    };

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
          "browser.startup.homepage" = "https://welkin.ckgxrg.io";
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
            browserpass
            surfingkeys
          ];
          settings = {
            # Dark background light text
            "jid1-QoFqdK4qzUfGWQ@jetpack".settings = with config.lib.stylix.colors; {
              default_background_color = "#${base00}";
              default_link_color = "#${base05}";
              default_visited_color = "#${base06}";
              default_active_color = "#${base0A}";
              default_selection_color = "#${base02}";
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
              '';
            };
          };
        };
      };
    };
  };
}
