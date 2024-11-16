{ pkgs, lib, ... }:
{
  # The `lf` file manager
  programs.lf = {
    enable = true;
    commands = {
      get-mime-type = "%xdg-mime query filetype \"$f\"";
    };
    settings = {
      drawbox = true;
      roundbox = true;
      relativenumber = true;
      icons = true;
      mouse = true;
      sixel = true;
      previewer = lib.getExe pkgs.pistol;
    };
  };

  # `Pistol` terminal file previewer
  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "image/*";
        command = "chafa -f sixel %pistol-filename%";
      }
      {
        mime = "text/*";
        command = "bat %pistol-filename%";
      }
    ];
  };

  # Convert pictures to sixel, in order to be previewed.
  home.packages = with pkgs; [
    chafa
    bat
  ];
}
