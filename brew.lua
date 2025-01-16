local config = require("config")
local dark = require("nvim-web-devicons.icons-default")
local light = require("nvim-web-devicons.icons-light")
local prepare = require("prepare")

local function rearrange(by)
	local map = {}
	local source = by == "exts" and "icons_by_file_extension" or "icons_by_filename"
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
	table.sort(list, function(a, b) return a.name:lower() < b.name:lower() end)
	local dark_blend, light_blend = "", ""
	local dark, light = "", ""
	for _, v in ipairs(list) do
		dark_blend = prepare.matching_colors(v.fg_dark, config.dark_colors_table, config.factors, config.precise_search)
		light_blend = prepare.matching_colors(v.fg_light, config.light_colors_table, config.factors, config.precise_search)

		dark = dark .. string.format('\t{ name = "%s", text = "%s", fg = "%s" },\n', v.name, v.text, dark_blend)
		light = light .. string.format('\t{ name = "%s", text = "%s", fg = "%s" },\n', v.name, v.text, light_blend)
	end
	return dark, light
end

function save(typ, files, exts)
	local p = string.format("theme-%s.toml", typ)
	local s = io.open(p, "r"):read("*a")
	s = s:gsub("files = %[\n(.-)\n%]", string.format("files = [\n%s]", files))
	s = s:gsub("exts = %[\n(.-)\n%]", string.format("exts = [\n%s]", exts))
	io.open(p, "w"):write(s)
end

local dark_files, light_files = fill(rearrange("files"))
local dark_exts, light_exts = fill(rearrange("exts"))

save("dark", dark_files, dark_exts)
save("light", light_files, light_exts)
