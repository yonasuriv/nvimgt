-- nvimGT astrodark — base46 theme aligned with AstroNvim AstroDark palette
-- Source: https://github.com/AstroNvim/astrotheme (astrodark.lua)

local M = {}

M.base_30 = {
  white = "#E0E0EE",
  darker_black = "#111317",
  black = "#1A1D23",
  black2 = "#16181D",
  one_bg = "#1A1D23",
  one_bg2 = "#1E222A",
  one_bg3 = "#23272F",
  grey = "#3A3E47",
  grey_fg = "#494D56",
  grey_fg2 = "#595C66",
  light_grey = "#696C76",
  red = "#FF838B",
  baby_pink = "#de8c92",
  pink = "#FF838B",
  line = "#3A3E47",
  green = "#87C05F",
  vibrant_green = "#75AD47",
  nord_blue = "#5EB7FF",
  blue = "#50A4E9",
  yellow = "#DFAB25",
  sun = "#D09214",
  purple = "#DD97F1",
  dark_purple = "#CC83E3",
  teal = "#4AC2B8",
  orange = "#F5983A",
  cyan = "#00B298",
  statusline_bg = "#111317",
  lightbg = "#1E222A",
  pmenu_bg = "#50A4E9",
  folder_bg = "#50A4E9",
}

M.base_16 = {
  base00 = "#1A1D23",
  base01 = "#1E222A",
  base02 = "#23272F",
  base03 = "#3A3E47",
  base04 = "#494D56",
  base05 = "#9B9FA9",
  base06 = "#ADB0BB",
  base07 = "#E0E0EE",
  base08 = "#FF838B",
  base09 = "#F5983A",
  base0A = "#DFAB25",
  base0B = "#87C05F",
  base0C = "#4AC2B8",
  base0D = "#50A4E9",
  base0E = "#DD97F1",
  base0F = "#F8747E",
}

M.type = "dark"

M = require("base46").override_theme(M, "astrodark")

return M
