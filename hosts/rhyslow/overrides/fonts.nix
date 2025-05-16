{ ckgs, ... }:
# Make a custom font overriding
{
  fonts = {
    fontDir.enable = true;
    packages = [
      ckgs.maple-ui
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Maple UI"
        ];
        serif = [
          "Maple UI"
        ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <alias>
            <family>Jost*</family>
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
