{ ... }: {
  # The Neovim editos
  imports = [
    ./autocmd.nix
    ./lsp.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    clipboard.providers.wl-copy.enable = true;
  };
}