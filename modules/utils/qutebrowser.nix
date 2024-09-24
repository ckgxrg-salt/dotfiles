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
      "prts" = "https://prts.wiki/index.php?title=特殊:搜索&search={}";
      "wp" = "https://en.wikipedia.org/w/index.php?search={}";
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
    settings = {
      auto_save.session = true;
      changelog_after_upgrade = "never";
      tabs.last_close = "close";
      content.cookies.accept = "no-unknown-3rdparty";
      content.headers.do_not_track = true;
      colors.webpage.preferred_color_scheme = "dark";
      fonts.default_family = "Maple Mono";
      zoom.default = "125%";
      url.start_pages = "about:blank";
    };
  };
}
