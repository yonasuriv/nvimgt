local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local function load_base46_ui()
  local cache = vim.g.base46_cache
  if not cache then
    return
  end
  for _, name in ipairs({ "defaults", "statusline" }) do
    local path = cache .. name
    if vim.fn.filereadable(path) == 1 then
      dofile(path)
    end
  end
end

require("lazy").setup({
  spec = {
    -- Base plugin specs (LazyVim — see Credits; migrating toward nvimGT lazyload layer)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- nvimGT-owned plugin overrides and additions
    { import = "nvimgt.plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

load_base46_ui()

local commands = require("nvimgt.utils.commands")
commands.setup_abbrevs()
commands.setup_commands()

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    load_base46_ui()
  end,
})
