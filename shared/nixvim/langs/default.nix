{ ... }:
{
  imports = [
    ./java.nix
    ./rust.nix
  ];

  programs.nixvim.plugins = {
    # Working with Nix
    nix = {
      enable = true;
    };
    nix-develop = {
      enable = true;
    };

    # Markdown preview
    markdown-preview = {
      enable = true;
      settings = {
        browser = "firefox";
        theme = "dark";
      };
    };

    # Other language servers
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
      };
    };
  };
}
