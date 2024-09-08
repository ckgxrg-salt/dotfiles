{ ... }: {
  # Include Alacritty's theme config
  xdg.configFile."alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.9
    blur = true
    decorations_theme_variant = "Dark"

    [colors.primary]
    foreground = "#a9b1d6"
    background = "#1a1b26"

    [colors.normal]
    black = "#32344a"
    red = "#f7768e"
    green = "#9ece6a"
    yellow = "#e0af68"
    blue = "#7aa2f7"
    magenta = "#ad8ee6"
    cyan = "#449dab"
    white = "#787c99"

    [colors.bright]
    black = "#444b6a"
    red = "#ff7a93"
    green = "#b9f27c"
    yellow = "#ff9e64"
    blue = "#7da6ff"
    magenta = "#bb9af7"
    cyan = "#0db9d7"
    white = "#acb0d0"
  '';
}
