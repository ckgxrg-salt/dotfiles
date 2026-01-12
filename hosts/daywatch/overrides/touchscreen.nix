{ ... }:
# Quirks for the touchscreen
{
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Touchscreen Quirks]
    MatchName=ELAN2514:00 04F3:4428
    MatchBus=i2c
    AttrPalmSizeThreshold=5
    AttrTouchSizeRange=4:3

    [Tablet Quirks]
    MatchName=ELAN2514:00 04F3:4428 Stylus
    MatchBus=i2c
    MatchUdevType=tablet
    AttrTabletSmoothing=0
  '';
}
