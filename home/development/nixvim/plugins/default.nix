pkgs: lib:
let
  plugins = [
    (import ./alpha.nix)
    (import ./completions.nix)
    (import ./debug.nix pkgs)
    (import ./editor.nix)
    (import ./lines.nix)
    (import ./misc.nix)
    (import ./neotest.nix)
    (import ./which-key.nix)

    (import ./langs/codestyle.nix)
    (import ./langs/jdtls.nix pkgs lib)
    (import ./langs/lsp.nix)
    (import ./langs/markdown.nix)
    (import ./langs/rustaceanvim.nix)
    (import ./langs/treesitter.nix pkgs)
  ];
  deepMerge = import ../merge.nix;
in
lib.foldl deepMerge { } plugins
