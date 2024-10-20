{ ... }:
{
  # The Neovim editos
  imports = [
    ./autocmd.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    clipboard.providers.wl-copy.enable = true;

    globalOpts = {
      wrapmargin = 1;
      textwidth = 0;
      formatoptions = "tcqj";
    };
  };
}
