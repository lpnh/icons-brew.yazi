local config = require("config")
local dark = require("nvim-web-devicons.icons-default")
local light = require("nvim-web-devicons.icons-light")

function rearrange(by)
	local map = {}
	local source = by == "exts" and "icons_by_file_extension" or "icons_by_filename"
	for k, v in pairs(dark[source]) do
		map[k] = map[k] or {}
		map[k].icon = v.icon
		map[k].number_dark = tonumber(v.cterm_color)
	end
	for k, v in pairs(light[source]) do
		map[k].number_light = tonumber(v.cterm_color)
	end
	return map
end

function fill(map)
	local list = {}
	for k, v in pairs(map) do
		list[#list + 1] = { name = k, text = v.icon, number_dark = v.number_dark, number_light = v.number_light }
	end
	table.sort(list, function(a, b) return a.name:lower() < b.name:lower() end)
	local dark_blend, light_blend = "", ""
	local dark, light = "", ""
	for _, v in ipairs(list) do
		dark_blend = config.get_color(config.dark, v.number_dark, v.name)
		light_blend = config.get_color(config.light, v.number_light, v.name)

		dark = dark .. string.format('\t{ name = "%s", text = "%s", fg = "%s" },\n', v.name, v.text, dark_blend)
		light = light .. string.format('\t{ name = "%s", text = "%s", fg = "%s" },\n', v.name, v.text, light_blend)
	end
	return dark, light
end

function save(th, files, exts)
	local p = string.format("theme-%s.toml", th)
	local s = string.format("[icon]\n\nfiles = [\n%s]\nexts = [\n%s]\n", files, exts)
	io.open(p, "w"):write(s)
end

local dark_files, light_files = fill(rearrange("files"))
local dark_exts, light_exts = fill(rearrange("exts"))

save("dark", dark_files, dark_exts)
save("light", light_files, light_exts)
