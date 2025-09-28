{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.floorp;
in
{
  options.program.floorp = {
    enable = mkEnableOption "Enable Floorp web browser";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of extra Firefox extensions";
    };
  };

  config = mkIf cfg.enable {
    stylix.targets.floorp = {
      enable = true;
      colorTheme.enable = true;
      profileNames = [ "default" ];
    };

    programs.browserpass = {
      browsers = [ "firefox" ];
    };

    programs.floorp = {
      enable = true;
      package = pkgs.floorp-bin;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
      ];
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
          default = "startpage";
          privateDefault = "startpage";
          force = true;
          engines = {
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
              definedAliases = [ "@rs" ];
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
          # Restore Session
          "browser.startup.page" = 3;
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
            disconnect
            browserpass
            tridactyl
          ];
          settings = {
            # Tridactyl
            "tridactyl.vim@cmcaine.co.uk".settings = {
              userconfig = {
                configversion = "2.0";
                smoothscroll = true;
                searchurls = {
                  "aw" = "https://wiki.archlinux.org/?search=%s";
                  "pkg" = "https://search.nixos.org/packages?channel=unstable&query=%s";
                  "opt" = "https://search.nixos.org/options?channel=unstable&query=%s";
                  "rs" = "https://crates.io/search?q=%s";
                  "bili" = "https://search.bilibili.com/all?keyword=%s";
                  "prts" = "https://prts.wiki/index.php?title=特殊:搜索&search=%s";
                };
                nmaps = {
                  "d" = "";
                  "." = "";
                };
              };
            };
          };
        };
      };
    };
  };
}
