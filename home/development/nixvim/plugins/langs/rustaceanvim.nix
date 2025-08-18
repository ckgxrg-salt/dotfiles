{
  plugins.rustaceanvim = {
    enable = true;
    settings = {
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
}
