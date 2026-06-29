-- nvimGT astrolight — base46 light theme (AstroNvim AstroLight palette)

local M = {}

M.base_30 = {
  white = "#17191C",
  darker_black = "#E1E2E4",
  black = "#F7F8F8",
  black2 = "#EAEBEB",
  one_bg = "#F7F8F8",
  one_bg2 = "#EAEBEB",
  one_bg3 = "#DADBDD",
  grey = "#B5B9BD",
  grey_fg = "#AEB3B6",
  grey_fg2 = "#8B9297",
  light_grey = "#737474",
  red = "#E72F1F",
  baby_pink = "#de8c92",
  pink = "#9E007C",
  line = "#E8E9EA",
  green = "#42AD17",
  vibrant_green = "#345E00",
  nord_blue = "#3F8CEA",
  blue = "#3F8CEA",
  yellow = "#E69400",
  sun = "#7300B8",
  purple = "#671FF0",
  dark_purple = "#9E007C",
  teal = "#21B386",
  orange = "#F0740A",
  cyan = "#00615B",
  statusline_bg = "#E1E2E4",
  lightbg = "#EAEBEB",
  pmenu_bg = "#671FF0",
  folder_bg = "#3F8CEA",
}

M.base_16 = {
  base00 = "#F7F8F8",
  base01 = "#EAEBEB",
  base02 = "#E7E9EB",
  base03 = "#DADBDD",
  base04 = "#AEB3B6",
  base05 = "#737474",
  base06 = "#424446",
  base07 = "#17191C",
  base08 = "#990000",
  base09 = "#A34500",
  base0A = "#7300B8",
  base0B = "#345E00",
  base0C = "#00615B",
  base0D = "#00508A",
  base0E = "#9E007C",
  base0F = "#E72F1F",
}

M.type = "light"

M = require("base46").override_theme(M, "astrolight")

return M
