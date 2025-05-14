{ ... }:
{
  programs.nixvim.plugins = {
    # Working with Rust
    rustaceanvim = {
      enable = true;
      settings = {
        dap.autoload_configurations = false;
        server = {
          default_settings = {
            rust-analyzer = {
              check = {
                command = "clippy";
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
