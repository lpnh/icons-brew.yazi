local M = {}

-- A table of hex colors that will be assigned to Yazi dark theme icons
-- You can add as many as you want and the order doesn't matter
-- Catppuccin's Mocha palette by default
M.dark_colors_table = {
  '#f5e0dc',
  '#f2cdcd',
  '#f5c2e7',
  '#cba6f7',
  '#f38ba8',
  '#eba0ac',
  '#fab387',
  '#f9e2af',
  '#a6e3a1',
  '#94e2d5',
  '#89dceb',
  '#74c7ec',
  '#89b4fa',
  '#b4befe',
  '#cdd6f4',
  '#bac2de',
  '#a6adc8',
  '#9399b2',
  '#7f849c',
  '#6c7086',
  '#585b70',
  '#45475a',
  '#313244',
  '#1e1e2e',
  '#181825',
  '#11111b',
}

-- A table of hex colors that will be assigned to Yazi light theme icons
-- You can add as many as you want and the order doesn't matter
-- Catppuccin's Latte palette by default
M.light_colors_table = {
  '#dc8a78',
  '#dd7878',
  '#ea76cb',
  '#8839ef',
  '#d20f39',
  '#e64553',
  '#fe640b',
  '#df8e1d',
  '#40a02b',
  '#179299',
  '#04a5e5',
  '#209fb5',
  '#1e66f5',
  '#7287fd',
  '#4c4f69',
  '#5c5f77',
  '#6c6f85',
  '#7c7f93',
  '#8c8fa1',
  '#9ca0b0',
  '#acb0be',
  '#bcc0cc',
  '#ccd0da',
  '#eff1f5',
  '#e6e9ef',
  '#dce0e8',
}

-- Factors that can be adjusted to get a better color matching
M.factors = {
  lightness = 1.75,
  chroma = 1,
  hue = 1.25,
}

-- Precise search can result in better colors matching
--   by automatically tweaking the factors
M.precise_search = {
  enabled = true,
  iteration = 10,
  precision = 20,
  threshold = 23,
}

return M
