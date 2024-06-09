local M = {}

local function atan2(y, x)
  local theta = math.atan(y / x)
  if x < 0 then
    theta = theta + math.pi
  end
  if theta < 0 then
    theta = theta + 2 * math.pi
  end
  return theta
end

--- @param lab1 table: LAB values of the first color
--- @param lab2 table: LAB values of the second color
--- @param factors table: Factors for LAB colorspace
--- @return number: CIEDE2000 color difference between the two colors
function M.ciede2000(lab1, lab2, factors)
  local l1, a1, b1 = lab1[1], lab1[2], lab1[3]
  local l2, a2, b2 = lab2[1], lab2[2], lab2[3]

  local k_l, k_c, k_h = factors.lightness, factors.chroma, factors.hue

  local delta_l = l2 - l1

  local c1 = math.sqrt(a1 * a1 + b1 * b1)
  local c2 = math.sqrt(a2 * a2 + b2 * b2)
  local c_bar = (c1 + c2) / 2

  local a_prime1 = a1 + (a1 / 2) * (1 - math.sqrt((c_bar ^ 7) / (c_bar ^ 7 + 25 ^ 7)))
  local a_prime2 = a2 + (a2 / 2) * (1 - math.sqrt((c_bar ^ 7) / (c_bar ^ 7 + 25 ^ 7)))

  local c_prime1 = math.sqrt(a_prime1 * a_prime1 + b1 * b1)
  local c_prime2 = math.sqrt(a_prime2 * a_prime2 + b2 * b2)

  local h_prime1 = atan2(b1, a_prime1)
  local h_prime2 = atan2(b2, a_prime2)

  h_prime1 = h_prime1 < 0 and h_prime1 + 2 * math.pi or h_prime1
  h_prime2 = h_prime2 < 0 and h_prime2 + 2 * math.pi or h_prime2

  local delta_h_prime = math.abs(h_prime1 - h_prime2) <= math.pi and h_prime2 - h_prime1
    or h_prime2 <= h_prime1 and h_prime2 - h_prime1 + 2 * math.pi
    or h_prime2 - h_prime1 - 2 * math.pi

  local delta_c_prime = c_prime2 - c_prime1
  local delta_h = 2 * math.sqrt(c_prime1 * c_prime2) * math.sin(delta_h_prime / 2)

  local l_prime_bar = (l1 + l2) / 2
  local c_prime_bar = (c_prime1 + c_prime2) / 2

  local h_prime_bar = math.abs(h_prime1 - h_prime2) > math.pi and (h_prime1 + h_prime2 + 2 * math.pi) / 2 or (h_prime1 + h_prime2) / 2

  local t = 1
    - 0.17 * math.cos(h_prime_bar - math.pi / 6)
    + 0.24 * math.cos(2 * h_prime_bar)
    + 0.32 * math.cos(3 * h_prime_bar + math.pi / 30)
    - 0.20 * math.cos(4 * h_prime_bar - 63 * math.pi / 180)

  local delta_theta = 30 * math.pi / 180 * math.exp(-((h_prime_bar - 275 * math.pi / 180) / (25 * math.pi / 180)) ^ 2)
  local r_c = 2 * math.sqrt((c_prime_bar ^ 7) / (c_prime_bar ^ 7 + 25 ^ 7))
  local s_l = 1 + (0.015 * (l_prime_bar - 50) ^ 2) / math.sqrt(20 + (l_prime_bar - 50) ^ 2)
  local s_c = 1 + 0.045 * c_prime_bar
  local s_h = 1 + 0.015 * c_prime_bar * t
  local r_t = -math.sin(2 * delta_theta) * r_c

  local delta_e = math.sqrt(
    (delta_l / (k_l * s_l)) ^ 2
      + (delta_c_prime / (k_c * s_c)) ^ 2
      + (delta_h / (k_h * s_h)) ^ 2
      + r_t * (delta_c_prime / (k_c * s_c)) * (delta_h / (k_h * s_h))
  )

  return delta_e
end

return M
