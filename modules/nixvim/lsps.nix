{ ... }: {
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      clangd.enable = true;
      cmake.enable = true;
      java-language-server.enable = true;
      marksman.enable = true;
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            nixos.expr = "(builtins.getFlake (\"git+file:///home/ckgxrg/dotfiles\")).nixosConfigurations.Cshelipix.options";
          };
        };
      };
    };
  };
}