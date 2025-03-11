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
        "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
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
  };
}
