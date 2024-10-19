{ pkgs, ... }:
{
  # A lightweight web browser
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      "DEFAULT" = "https://bing.com/search?q={}";
      "g" = "https://google.com/search?q={}";
      "aw" = "https://wiki.archlinux.org/?search={}";
      "np" = "https://search.nixos.org/packages?channel=unstable&query={}";
      "no" = "https://search.nixos.org/options?channel=unstable&query={}";
      "bili" = "https://search.bilibili.com/all?keyword={}";
      "prts" = "https://prts.wiki/index.php?title=特殊:搜索&search={}";
      "wp" = "https://en.wikipedia.org/w/index.php?search={}";
      "trans" = "https://www.deepl.com/en/translator?il=zh#zh/en_gb/{}";
    };
    # Apply the colorscheme
    extraConfig =
      let
        src = pkgs.fetchgit {
          url = "https://gist.github.com/04704c7860704aef5067491f5332005d.git";
          rev = "9db514efa5bfe373097cf8bb8cd0b0fa55203c2d";
          hash = "sha256-1DiqL5gQhJ7l8ympdsIVq1wql4HwiyX/0BAJwA+gVmk=";
        };
      in
      builtins.readFile "${src}/everforest.py"
      + ''
        set(c, scheme = 'dark', intensity = 'medium')
      '';
    settings = {
      auto_save.session = true;
      changelog_after_upgrade = "never";
      tabs = {
        last_close = "close";
        new_position.unrelated = "next";
        favicons.scale = 1.5;
        "padding['bottom']" = 7;
        "padding['left']" = 7;
        "padding['right']" = 7;
        "padding['top']" = 7;
      };
      content = {
        cookies.accept = "no-unknown-3rdparty";
        headers.do_not_track = true;
      };
      colors.webpage.preferred_color_scheme = "dark";
      fonts.default_family = "Maple Mono";
      zoom.default = "125%";
      url = {
        start_pages = "about:blank";
        default_page = "about:blank";
        open_base_url = true;
      };
    };
  };
}
