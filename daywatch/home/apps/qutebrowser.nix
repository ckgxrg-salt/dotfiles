{ ckgs, ... }:
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
      import sys
      sys.path.append('${ckgs.qutebrowser-everforest}')
      import everforest
      everforest.set(c, scheme = 'dark', intensity = 'soft')
    '';
    keyBindings = {
      normal = {
        "pw" = "spawn --userscript qute-pass";
        # Align with standard vim keybind
        "H" = "tab-prev";
        "L" = "tab-next";
        "<Shift-left>" = "back";
        "<Shift-right>" = "forward";
        "J" = "nop";
        "K" = "nop";
        "." = "nop";
        "d" = "nop";
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
