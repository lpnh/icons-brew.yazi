local dark = require 'nvim-web-devicons.icons-default'
local light = require 'nvim-web-devicons.icons-light'
local config = require 'config'
local prepare = require 'prepare'

local function rearrange(by)
  local map = {}
  local source = by == 'exts' and 'icons_by_file_extension' or 'icons_by_filename'
  for k, v in pairs(dark[source]) do
    map[k] = map[k] or {}
    map[k].icon = v.icon
    map[k].fg_dark = v.color:lower()
  end
  for k, v in pairs(light[source]) do
    map[k].fg_light = v.color:lower()
  end
  return map
end

local function fill(map)
  local list = {}
  for k, v in pairs(map) do
    list[#list + 1] = { name = k, text = v.icon, fg_dark = v.fg_dark, fg_light = v.fg_light }
  end
  table.sort(list, function(a, b)
    return a.name:lower() < b.name:lower()
  end)
  for _, v in ipairs(list) do
    local dark_blend = prepare.matching_colors(v.fg_dark, config.dark_colors_table, config.factors, config.precise_search)
    local light_blend = prepare.matching_colors(v.fg_light, config.light_colors_table, config.factors, config.precise_search)
    -- stylua: ignore
    print(string.format('\t{ name = "%s", text = "%s", fg_dark = "%s", fg_light = "%s" },', v.name, v.text, dark_blend, light_blend))
  end
end

print '[icon]'
print 'files = ['
fill(rearrange 'files')
print ']'

print 'exts = ['
fill(rearrange 'exts')
print ']'
