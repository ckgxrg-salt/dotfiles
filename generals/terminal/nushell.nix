{ pkgs, ... }:
{
  # A new type of shell
  programs.nushell =
    let
      themePkg = pkgs.callPackage ../../packages/nu-scripts.nix { theme = "tokyo-storm"; };
    in
    {
      enable = true;

      # Config file is written in Nu, and there are some issues converting Nix to Nu. 
      configFile.text = ''
        $env.config = {
          show_banner: false
          error_style: "fancy"
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

        source ${themePkg}/themes/tokyo-storm.nu

        $env.MANPAGER = "nvim +Man!";
        $env.LS_COLORS = (vivid generate tokyonight-storm | str trim)

        def ciallo [] { fortune | cowsay | lolcat }
        def clear [] { ^clear; ciallo }

        alias true-clear = ^clear
        alias deploy = nh os switch --ask
        alias purge = nh clean all --ask

        ciallo
      '';
    };
}
