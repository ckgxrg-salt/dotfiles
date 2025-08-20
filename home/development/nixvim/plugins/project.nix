{
  plugins = {
    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        detection_methods = [
          "lsp"
          "pattern"
        ];
        patterns = [
          ".git"
          "flake.nix"
          "Makefile"
          "Cargo.toml"
          "./gradlew"
        ];
        scope_chdir = "global";
        silent_chdir = true;
      };
    };

    auto-session = {
      enable = true;
    };
  };
}
