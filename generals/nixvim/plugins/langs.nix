{ pkgs, lib, ... }:
{
  # Lombok support
  programs.nixvim.extraPackages = with pkgs; [
    lombok
  ];
  programs.nixvim.plugins = {
    # Working with Java
    nvim-jdtls = {
      enable = true;
      rootDir.__raw = "vim.fs.root(0, {\".git\", \"mvnw\", \"gradlew\"})";
      cmd = [ "Surprisingly, you cannot use Lua code here, though this option is mandatory. " ];
      extraOptions.cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
        "--jvm-arg=javaagent:${pkgs.lombok}/share/java/lombok.jar"
        "-configuration"
        { __raw = "vim.fn.expand(\"$XDG_CACHE_HOME/jdtls/config\")"; }
        "-data"
        { __raw = "vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:h')"; }
      ];
      settings = {
        java = {
          codeGeneration = {
            useBlocks = true;
            generateComments = true;
            toString = {
              template = "\${object.className}{\${member.name()}=\${member.value},\${otherMembers}}";
            };
          };
        };
      };
    };

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
                command = "cargo-clippy";
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

    # Other language servers
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        denols.enable = true;
      };
    };
  };
}
