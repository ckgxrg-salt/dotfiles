{
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        completion = {
          accept = {
            dot_repeat = false;
          };
          list.selection.preselect = false;
          documentation.auto_show = true;
        };
        signature.enabled = true;
        keymap = {
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<C-Tab>" = [ "show" ];
          "<Tab>" = [
            "select_next"
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "select_prev"
            "snippet_backward"
            "fallback"
          ];
        };
        cmdline.completion.ghost_text.enabled = false;
      };
    };

    friendly-snippets.enable = true;
  };
}
