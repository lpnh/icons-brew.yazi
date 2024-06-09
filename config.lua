local M = {}

-- A table of hex colors used to assign colors to the icons
--   It uses catppuccin's Mocha color palette by default
M.colors_table = {
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
