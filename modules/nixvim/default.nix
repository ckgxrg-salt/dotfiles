{ ... }: {
  # The Nixvim editos
  imports = [
    ./autocmd.nix
    ./theme.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.providers.wl-copy.enable = true;
  };
}