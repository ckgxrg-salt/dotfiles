{ ... }: {
  # The Nixvim editos
  imports = [
    ./autocmd.nix
    ./lsps.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.providers.wl-copy.enable = true;
  };
}