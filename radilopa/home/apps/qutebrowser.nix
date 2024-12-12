{ pkgs, ... }:
{
  # A lightweight web browser
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      "DEFAULT" = "https://bing.com/search?q={}";
      "g" = "https://google.com/search?q={}";
      "aw" = "https://wiki.archlinux.org/?search={}";
      "pkg" = "https://search.nixos.org/packages?channel=unstable&query={}";
      "opt" = "https://search.nixos.org/options?channel=unstable&query={}";
      "bili" = "https://search.bilibili.com/all?keyword={}";
      "prts" = "https://prts.wiki/index.php?title=特殊:搜索&search={}";
      "wp" = "https://en.wikipedia.org/w/index.php?search={}";
      "trans" = "https://www.deepl.com/en/translator?il=zh#zh/en_gb/{}";
    };
    # Apply the colorscheme
    extraConfig = ''
      config.source('${
        pkgs.fetchFromGitHub {
          owner = "gicrisf";
          repo = "qute-city-lights";
          rev = "047d5306ce6ce74d17b2d3a58b9419c89a0fb238";
          hash = "sha256-khIH2oDgL9+K6Z6GxXfm3qVEA1vIOwNASULHTP6P1sw=";
        }
      }/city-lights-theme.py')
    '';
    keyBindings = {
      normal = {
        "pw" = "spawn --userscript qute-pass";
      };
      insert = {
        "<Alt-Shift-u>" = "spawn --userscript qute-pass";
      };
    };
    settings = {
      auto_save.session = true;
      changelog_after_upgrade = "never";
      tabs = {
        last_close = "close";
        new_position.unrelated = "next";
        favicons.scale = 1.5;
        "padding['bottom']" = 10;
        "padding['left']" = 7;
        "padding['right']" = 7;
        "padding['top']" = 10;
      };
      content = {
        cookies.accept = "no-unknown-3rdparty";
        headers.do_not_track = true;
      };
      colors.webpage.preferred_color_scheme = "dark";
      fonts = {
        default_family = "Maple UI";
        web.family = {
          fixed = "Maple Mono SC NF";
          sans_serif = "Maple UI";
          serif = "Maple UI";
          standard = "Maple UI";
        };
      };
      zoom.default = "125%";
      url = {
        start_pages = "about:blank";
        default_page = "about:blank";
        open_base_url = true;
      };
    };
  };
}
