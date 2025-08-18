pkgs: lib:
let
  plugins = [
    (import ./alpha.nix)
    (import ./completions.nix)
    (import ./components.nix)
    (import ./debug.nix pkgs)
    (import ./lines.nix)
    (import ./misc.nix)
    (import ./project.nix)
    (import ./which-key.nix)

    (import ./langs/codestyle.nix)
    (import ./langs/jdtls.nix pkgs lib)
    (import ./langs/lsp.nix)
    (import ./langs/rustaceanvim.nix)
    (import ./langs/treesitter.nix pkgs)
  ];
  deepMerge = import ../merge.nix;
in
lib.foldl deepMerge { } plugins
