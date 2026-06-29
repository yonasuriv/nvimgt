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
    -- Prefer AstroDark on first install, fall back to LazyVim defaults
    colorscheme = { "astrodark", "tokyonight", "habamax" },
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

-- nvimGT command aliases — abbrevs call nvimgt.util.commands (see lua/nvimgt/util/commands.lua)
-- :die and :bye work without ! (same as :qa). Use :die! / :bye! to force quit.
require("nvimgt.util.commands").setup_abbrevs()

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    vim.api.nvim_create_user_command("NvimgtFresh", function()
      local path = vim.g.lazyvim_json or (vim.fn.stdpath("config") .. "/config.json")
      local ok, err = os.remove(path)
      if ok then
        vim.notify("Removed " .. path .. " — restart Neovim to load shipped defaults.", vim.log.levels.INFO)
      else
        vim.notify("Could not remove " .. path .. (err and (": " .. err) or ""), vim.log.levels.ERROR)
      end
    end, { desc = "Delete config.json and restart to reset extras to shipped defaults" })
  end,
})
