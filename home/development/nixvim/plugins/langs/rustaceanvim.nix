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

  extraFiles."after/ftplugin/rust.lua".text = ''
    vim.keymap.set('n', '<leader>ds', ':RustLsp debuggables<CR>', { desc = 'Rust: Debug targets', buffer = true })
    vim.keymap.set('n', '<leader>rr', ':RustLsp runnables<CR>', { desc = 'Rust: Run targets', buffer = true })
    vim.keymap.set('n', '<leader>re', ':RustLsp testables<CR>', { desc = 'Rust: Test targets', buffer = true })
    vim.keymap.set('n', '<leader>cx', ':RustLsp expandMacro<CR>', { desc = 'Rust: Expand macro', buffer = true })
    vim.keymap.set('n', '<leader>cX', ':RustLsp explainError current<CR>', { desc = 'Rust: Explain error', buffer = true })
    vim.keymap.set('n', '<leader>cc', ':RustLsp openDocs<CR>', { desc = 'Rust: Open docs.rs', buffer = true })
  '';
}
