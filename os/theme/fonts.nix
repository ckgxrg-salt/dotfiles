{ lib, ... }:
{
  options.theme.font = with lib.types; {
    size = mkOption {
      type = types.int;
      default = 32;
      description = "The cursor size";
    };
  };
}
