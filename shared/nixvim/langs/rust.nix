{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    # Working with Rust
    rustaceanvim = {
      enable = true;
      rustAnalyzerPackage = pkgs.rust-analyzer;
      settings = {
        dap.autoload_configurations = false;
        server = {
          default_settings = {
            rust-analyzer = {
              check = {
                command = "cargo clippy";
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
            };
          };
          standalone = false;
        };
        tools = {
          enable_clippy = true;
        };
      };
    };
  };
}
