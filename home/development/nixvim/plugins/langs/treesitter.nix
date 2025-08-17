pkgs: {
  plugins.treesitter = {
    enable = true;
    folding = true;

    nixGrammars = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      json
      markdown
      nix
      toml
      rust
      java
      typescript
      cpp
    ];

    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      indent.enable = true;
      rainbow = {
        enable = true;
        extended_mode = true;
        max_file_lines = "nil";
      };
    };
  };
}
