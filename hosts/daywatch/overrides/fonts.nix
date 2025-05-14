{ pkgs, ... }:
# Make a custom font overriding
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-emoji
      maple-mono.NF
      jost
      ckgs.maple-ui
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Maple Mono NF"
        ];
        sansSerif = [
          "Maple UI"
          "Jost*"
        ];
        serif = [
          "Maple UI"
          "Jost*"
        ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <alias>
            <family>Maple UI</family>
            <prefer>
              <family>Jost*</family>
              <family>Maple UI</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
  };
}
