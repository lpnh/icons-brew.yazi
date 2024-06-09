local convert = require 'prepare.convert'
local some_math = require 'prepare.some-math'

local M = {}

local function get_nearest_color(lab, lab_colors_table, factors)
  local nearest_color = '#FFFFFF'
  local nearest_distance = math.huge

  for rgb_value, lab_value in pairs(lab_colors_table) do
    local distance = some_math.ciede2000(lab, lab_value, factors)

    if distance < nearest_distance then
      nearest_color = rgb_value
      nearest_distance = distance
    end
  end

  return nearest_color, nearest_distance
end

local function precise_search(lab, colors_table, factors, opts)
  local nearest_color = '#FFFFFF'
  local nearest_distance = math.huge
  local i = 0

  while nearest_distance > opts.threshold and i < opts.iteration do
    local offset = 1 / opts.precision

    factors.lightness = factors.lightness + offset
    factors.hue = factors.hue + offset / 4

    nearest_color, nearest_distance = get_nearest_color(lab, colors_table, factors)

    i = i + 1
  end

  return nearest_color
end

--- @param default_color string: Icon's default hexadecimal color
--- @param colors_table table: Table of colors to compare with
--- @param factors table: Factors for LAB colorspace
--- @return string: Hexadecimal value of the nearest table color
function M.matching_colors(default_color, colors_table, factors, precise_search_opts)
  if precise_search_opts == nil then
    precise_search_opts = {}
  end

  local nearest_color = '#FFFFFF'
  local nearest_distance = math.huge
  local rgb_color = convert.hex_to_rgb(default_color)
  local lab = convert.rgb_to_lab(rgb_color[1], rgb_color[2], rgb_color[3])
  local lab_colors_table = convert.colors_table_to_lab(colors_table)

  nearest_color, nearest_distance = get_nearest_color(lab, lab_colors_table, factors)

  local threshold = precise_search_opts.threshold
  if nearest_distance > threshold and precise_search_opts.enabled == true then
    nearest_color = precise_search(lab, lab_colors_table, factors, precise_search_opts)
  end

  return nearest_color
end

return M
