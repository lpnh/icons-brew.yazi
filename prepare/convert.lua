local M = {}

--- @param r number: Red component of the color
--- @param g number: Green component of the color
--- @param b number: Blue component of the color
--- @return number: X component of the color
--- @return number: Y component of the color
--- @return number: Z component of the color
local function rgb_to_xyz(r, g, b)
  local function pivot_rgb(n)
    return n > 0.04045 and ((n + 0.055) / 1.055) ^ 2.4 or n / 12.92
  end

  r, g, b = pivot_rgb(r / 255), pivot_rgb(g / 255), pivot_rgb(b / 255)

  local x = r * 0.4124564 + g * 0.3575761 + b * 0.1804375
  local y = r * 0.2126729 + g * 0.7151522 + b * 0.0721750
  local z = r * 0.0193339 + g * 0.1191920 + b * 0.9503041

  return x * 100, y * 100, z * 100
end

--- @param x number: X component of the color
--- @param y number: Y component of the color
--- @param z number: Z component of the color
--- @return table: LAB values of the color
local function xyz_to_lab(x, y, z)
  local function pivot_XYZ(n)
    return n > 0.008856 and n ^ (1 / 3) or (7.787 * n) + (16 / 116)
  end

  local refX, refY, refZ = 95.047, 100.000, 108.883
  x, y, z = x / refX, y / refY, z / refZ

  x, y, z = pivot_XYZ(x), pivot_XYZ(y), pivot_XYZ(z)

  local l = (116 * y) - 16
  local a = 500 * (x - y)
  local b = 200 * (y - z)

  return { l, a, b }
end

--- @param r number: Red component of the color
--- @param g number: Green component of the color
--- @param b number: Blue component of the color
--- @return table: LAB values of the color
function M.rgb_to_lab(r, g, b)
  local x, y, z = rgb_to_xyz(r, g, b)
  return xyz_to_lab(x, y, z)
end

--- @param hex string: Hexadecimal value of the color
--- @return table: RGB values of the color
function M.hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  return {
    tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16),
  }
end

function M.colors_table_to_lab(colors_table)
  local new_colors_table = {}

  for _, value in pairs(colors_table) do
    if type(value) == 'string' then
      value = value:lower()
      if value ~= 'none' and value ~= 'null' then
        local rgb = M.hex_to_rgb(value)
        local lab = M.rgb_to_lab(rgb[1], rgb[2], rgb[3])

        new_colors_table[value] = lab
      end
    end
  end

  return new_colors_table
end

return M
