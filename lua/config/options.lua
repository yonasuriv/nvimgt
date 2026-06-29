-- nvimGT options
-- LazyVim defaults are always loaded first; add nvimGT-specific overrides here.

local opt = vim.opt

-- Global statusline (single bar at the bottom, like LazyVim defaults)
opt.laststatus = 3

-- Always show the top tabline so the nvimGT buffer/tab bar is visible
opt.showtabline = 2
