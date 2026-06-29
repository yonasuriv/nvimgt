-- nvimGT — eXtended Line-editor Visual Improved Mode
-- Entry point: bootstrap lazy.nvim and load nvimGT plugins

-- LazyVim extras state file (default is lazyvim.json; nvimGT uses config.json)
vim.g.lazyvim_json = vim.fn.stdpath("config") .. "/config.json"

-- NvChad base46 highlight cache (required by NvChad/ui statusline + tabufline)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

for _, name in ipairs({ "options", "keymaps", "autocmds" }) do
  package.preload["config." .. name] = function()
    return require("nvimgt.config." .. name)
  end
end

-- NvChad/ui expects require("chadrc"); nvimGT config lives at nvimgt.config.theme
package.preload["chadrc"] = function()
  return require("nvimgt.config.theme")
end

require("nvimgt.config.lazy")