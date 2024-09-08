{ ... }:
{
  # A new type of shell
  programs.nushell = {
    enable = true;

    # Config file is written in Nu, and there are some issues converting Nix to Nu. 
    configFile.text = ''
      $env.config = {
        show_banner: false
        error_style: "fancy"
        display_errors: {
          exit_code: true
          termination_signal: true
        }
        table: {
          mode: reinforced
          index_mode: auto
        }
        completions: {
          case_sensitive: false
          algorithm: "fuzzy"
        }
        filesize: {
          metric: true
        }
      }

      $env.MANPAGER = "nvim +Man!";

      def ciallo [] { fortune | cowsay | lolcat }
      def clear [] { ^clear; ciallo }

      alias true-clear = ^clear
      alias deploy = nh os switch --ask
      alias purge = nh clean all --ask
    '';
  };
}