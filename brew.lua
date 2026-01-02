local config = require("config")
local dark = require("nvim-web-devicons.icons-default")
local light = require("nvim-web-devicons.icons-light")

function get_color(theme, icon_number, icon_name)
	for group, number_table in pairs(config.groups) do
		for _, n in ipairs(number_table) do
			if n == icon_number then
				local color = theme[group]
				if not color then
					error(string.format("Group `%s` missing from theme (icon: %s)", group, icon_name))
				end
				assert(
					color:match("^#%x%x%x%x%x%x$"),
					string.format("Invalid color value `%s` in group `%s` (icon: %s)", color, group, icon_name)
				)
				return color
			end
		end
	end
	error(string.format("Number `%d` not found in any group (icon: %s)", icon_number, icon_name))
end

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

function fill(map, field)
	local list = {}
	for k, v in pairs(map) do
		list[#list + 1] = { name = k, text = v.icon, number_dark = v.number_dark, number_light = v.number_light }
	end
	table.sort(list, function(a, b) return a.name:lower() < b.name:lower() end)
	local dark_blend, light_blend = "", ""
	local dark, light = "", ""
	for _, v in ipairs(list) do
		dark_blend = get_color(config.dark, v.number_dark, v.name)
		light_blend = get_color(config.light, v.number_light, v.name)

		dark = dark .. string.format('\t{ %s = "%s", text = "%s", fg = "%s" },\n', field, v.name, v.text, dark_blend)
		light = light .. string.format('\t{ %s = "%s", text = "%s", fg = "%s" },\n', field, v.name, v.text, light_blend)
	end
	return dark, light
end

function save(th, globs, files, exts)
	local p = string.format("theme-%s.toml", th)
	local s = globs and string.format("[icon]\n\nglobs = [\n%s]\nfiles = [\n%s]\nexts = [\n%s]\n", globs, files, exts)
		or string.format("[icon]\n\nfiles = [\n%s]\nexts = [\n%s]\n", files, exts)
	io.open(p, "w"):write(s)
end

local exts_map = rearrange("exts")
local files_map = rearrange("files")
local dark_files, light_files = fill(files_map, "name")
local dark_exts, light_exts = fill(exts_map, "name")

local dark_globs, light_globs
if config.glob_patterns and next(config.glob_patterns) then
	local globs_map = {}
	for pattern, name in pairs(config.glob_patterns) do
		assert(type(pattern) == "string", "invalid glob pattern")
		local icon = exts_map[name] or files_map[name]
		assert(icon, string.format("filename or extension '%s' not found for glob pattern '%s'", name, pattern))
		globs_map[pattern] = icon
	end
	dark_globs, light_globs = fill(globs_map, "url")
end

save("dark", dark_globs, dark_files, dark_exts)
save("light", light_globs, light_files, light_exts)
