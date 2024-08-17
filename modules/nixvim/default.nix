{ ... }: {
  # The Nixvim editos
  imports = [
    ./autocmd.nix
    ./lsp.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    clipboard.providers.wl-copy.enable = true;
  };
}