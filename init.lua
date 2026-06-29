-- nvimGT — eXtended Line-editor Visual Improved Mode
-- Entry point: bootstrap lazy.nvim and load nvimGT plugins

-- LazyVim extras state file (default is lazyvim.json; nvimGT uses config.json)
vim.g.lazyvim_json = vim.fn.stdpath("config") .. "/config.json"

for _, name in ipairs({ "options", "keymaps", "autocmds" }) do
  package.preload["config." .. name] = function()
    return require("nvimgt.config." .. name)
  end
end

require("nvimgt.config.lazy")