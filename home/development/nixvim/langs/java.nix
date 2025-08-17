{ pkgs, lib, ... }:
{
  # Lombok support
  programs.nixvim.extraPackages = with pkgs; [
    lombok
  ];
  programs.nixvim.plugins = {
    # Working with Java
    jdtls = {
      enable = true;
      settings = {
        root_dir.__raw = "require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})";
        cmd = [
          "${lib.getExe pkgs.jdt-language-server}"
          "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
          "-configuration"
          { __raw = "vim.fn.expand(\"$XDG_CACHE_HOME/jdtls/config\")"; }
          "-data"
          { __raw = "vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:h')"; }
        ];
        init_options = {
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
  };
}
