local M = {}

-- stylua: ignore start
M.dark = {
  ["grey"]           = "#7f849c", -- Overlay1
  ["red"]            = "#f38ba8", -- Red
  ["green"]          = "#a6e3a1", -- Green
  ["yellow"]         = "#fab387", -- Peach
  ["blue"]           = "#89b4fa", -- Blue
  ["magenta"]        = "#cba6f7", -- Mauve
  ["cyan"]           = "#94e2d5", -- Teal
  ["bright_grey"]    = "#cdd6f4", -- Text
  ["bright_red"]     = "#eba0ac", -- Maroon
  ["bright_green"]   = "#a6e3a1", -- Green
  ["bright_yellow"]  = "#f9e2af", -- Yellow
  ["bright_blue"]    = "#89b4fa", -- Blue
  ["bright_magenta"] = "#cba6f7", -- Mauve
  ["bright_cyan"]    = "#74c7ec", -- Sapphire
}

M.light = {
  ["grey"]           = "#5c5f77", -- Subtext1
  ["red"]            = "#d20f39", -- Red
  ["green"]          = "#40a02b", -- Green
  ["yellow"]         = "#df8e1d", -- Yellow
  ["blue"]           = "#1e66f5", -- Blue
  ["magenta"]        = "#8839ef", -- Mauve
  ["cyan"]           = "#179299", -- Teal
  ["bright_grey"]    = "#ccd0da", -- Surface0
  ["bright_red"]     = "#e64553", -- Maroon
  ["bright_green"]   = "#40a02b", -- Green
  ["bright_yellow"]  = "#df8e1d", -- Yellow
  ["bright_blue"]    = "#04a5e5", -- Sky
  ["bright_magenta"] = "#ea76cb", -- Pink
  ["bright_cyan"]    = "#209fb5", -- Sapphire
}

M.groups = {
  ["grey"]           = { 0, 8, 16, 59, 66, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243 },
  ["red"]            = { 1, 52, 88, 124, 160, 174, 196, 202, 209, 210, 217, 223, 224 },
  ["green"]          = { 2, 22, 28, 29, 64, 65, 70, 76, 77, 78, 82, 83, 84, 85, 107, 108, 112, 113, 114, 149, 150, 151 },
  ["yellow"]         = { 3, 58, 94, 100, 106, 101, 130, 136, 142, 143, 144, 148, 166, 172, 178, 180, 184, 208, 214, 215, 220, 227, 228 },
  ["blue"]           = { 4, 17, 18, 19, 20, 21, 24, 25, 26, 27, 57, 61, 62, 63, 68, 69, 75, 81, 99, 105, 111, 146, 225 },
  ["magenta"]        = { 5, 53, 54, 55, 56, 60, 89, 90, 91, 92, 93, 97, 98, 104, 125, 126, 127, 128, 129, 135, 139, 147, 161, 162, 163, 164, 169, 175, 176, 182, 197 },
  ["cyan"]           = { 6, 23, 30, 36, 72, 73, 79, 80, 109, 110, 115, 145, 152 },
  ["bright_grey"]    = { 7, 15, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255 },
  ["bright_red"]     = { 9, 95, 131, 132, 137, 138, 167, 168, 173, 181, 203, 204, 216 },
  ["bright_green"]   = { 10, 34, 35, 40, 41, 42, 46, 47, 48, 49, 71, 118, 119, 120, 121, 155, 156, 157, 191, 192 },
  ["bright_yellow"]  = { 11, 154, 179, 185, 186, 187, 190, 194, 221, 222, 226, 229, 230 },
  ["bright_blue"]    = { 12, 31, 32, 33, 39, 74, 117, 153 },
  ["bright_magenta"] = { 13, 96, 102, 103, 133, 134, 140, 141, 165, 170, 171, 177, 183, 198, 199, 200, 201, 205, 206, 207, 211, 212, 213, 218, 219 },
  ["bright_cyan"]    = { 14, 37, 38, 43, 44, 45, 50, 51, 67, 86, 87, 116, 122, 123, 158, 159, 188, 189, 193, 195, 231 },
}
-- stylua: ignore end

M.get_color = function(theme, icon_number, icon_name)
	for group, number_table in pairs(M.groups) do
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

return M
