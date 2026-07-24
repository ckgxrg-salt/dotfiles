$env.config.color_config = {
  separator: "{{base16.base03.default.hex}}"
  leading_trailing_space_bg: "{{base16.base04.default.hex}}"
  header: "{{base16.base0b.default.hex | lighten: 20}}"
  date: "{{base16.base0e.default.hex | lighten: 20}}"
  filesize: "{{base16.base0d.default.hex | lighten: 20}}"
  row_index: "{{base16.base0c.default.hex | lighten: 20}}"
  bool: "{{base16.base08.default.hex | lighten: 20}}"
  int: "{{base16.base0b.default.hex | lighten: 20}}"
  duration: "{{base16.base08.default.hex | lighten: 20}}"
  range: "{{base16.base08.default.hex | lighten: 20}}"
  float: "{{base16.base08.default.hex | lighten: 20}}"
  string: "{{base16.base04.default.hex}}"
  nothing: "{{base16.base08.default.hex | lighten: 20}}"
  binary: "{{base16.base08.default.hex | lighten: 20}}"
  cellpath: "{{base16.base08.default.hex | lighten: 20}}"
  hints: "{{base16.base03.default.hex}}"

  shape_garbage: { fg: "{{base16.base07.default.hex }}" bg: "{{base16.base08.default.hex | lighten: 20}}" }
  shape_bool: "{{base16.base0d.default.hex | lighten: 20}}"
  shape_int: { fg: "{{base16.base0e.default.hex | lighten: 20}}" attr: b }
  shape_float: { fg: "{{base16.base0e.default.hex | lighten: 20}}" attr: b }
  shape_range: { fg: "{{base16.base0a.default.hex | lighten: 20}}" attr: b }
  shape_internalcall: { fg: "{{base16.base0c.default.hex | lighten: 20}}" attr: b }
  shape_external: "{{base16.base0c.default.hex | lighten: 20}}"
  shape_externalarg: { fg: "{{base16.base0b.default.hex | lighten: 20}}" attr: b }
  shape_literal: "{{base16.base0d.default.hex | lighten: 20}}"
  shape_operator: "{{base16.base0a.default.hex | lighten: 20}}"
  shape_signature: { fg: "{{base16.base0b.default.hex | lighten: 20}}" attr: b }
  shape_string: "{{base16.base0b.default.hex | lighten: 20}}"
  shape_filepath: "{{base16.base0d.default.hex | lighten: 20}}"
  shape_globpattern: { fg: "{{base16.base0d.default.hex | lighten: 20}}" attr: b }
  shape_variable: "{{base16.base0e.default.hex | lighten: 20}}"
  shape_flag: { fg: "{{base16.base0d.default.hex | lighten: 20}}" attr: b }
  shape_custom: { attr: b }
}
