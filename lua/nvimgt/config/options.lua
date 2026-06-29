-- nvimGT options
-- Distribution defaults load first; add nvimGT-specific vim.opt overrides here.

local opt = vim.opt

-- Global statusline (single bar across all windows)
opt.laststatus = 3

-- Always show the top tabline so the nvimGT buffer/tab bar is visible
opt.showtabline = 2
