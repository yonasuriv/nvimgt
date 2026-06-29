-- nvimGT options
-- Distribution defaults load first; add nvimGT-specific vim.opt overrides here.

local opt = vim.opt

-- Global statusline (NvChad stl uses vim.o.statusline; laststatus 3 = one bar)
opt.laststatus = 3

-- tabufline sets showtabline; keep 2 so the bar is always visible
opt.showtabline = 2

-- Consistent line numbers (winbar gap previously broke the number column)
opt.number = true
opt.relativenumber = true
