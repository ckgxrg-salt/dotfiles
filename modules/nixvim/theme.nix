{ ... }: {
  # Nixvim themes
  programs.nixvim = {
    colorscheme = "rose-pine";
    colorschemes = {
      rose-pine = {
        enable = true;
        settings = {
          variant = "moon";
        };
      };
    };
  };
}