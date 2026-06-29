-- nvimGT command aliases — Lua helpers for dashboard/scripts; cmdline abbrevs in setup_abbrevs()
-- Neovim only allows uppercase :command names, so lowercase aliases use cnoreabbrev at the : prompt.
local M = {}

--- Open lazy.nvim plugin manager (alias for :Lazy)
function M.lazy(...)
  vim.cmd({ cmd = "Lazy", args = { ... } })
end

--- Browse optional language/tool packs (alias for :LazyExtras)
function M.extras()
  if vim.fn.exists(":LazyExtras") ~= 2 then
    vim.notify("LazyExtras not available yet — wait for startup to finish.", vim.log.levels.WARN)
    return
  end
  vim.cmd("LazyExtras")
end

--- NvChad keymap cheatsheet (alias for :NvCheatsheet)
function M.cheatsheet()
  if vim.fn.exists(":NvCheatsheet") ~= 2 then
    vim.notify("NvCheatsheet not available yet — wait for startup to finish.", vim.log.levels.WARN)
    return
  end
  vim.cmd("NvCheatsheet")
end

--- NvChad theme picker without catppuccin variants
function M.theme()
  require("nvimgt.utils.themes").open()
end

--- Quit all windows (alias for :qa). Pass true for force quit (:qa!).
function M.die(bang)
  vim.cmd("qa" .. (bang and "!" or ""))
end

--- Quit with save/discard prompt (used by tabufline close button)
function M.confirm_quit()
  vim.cmd("confirm qa")
end

--- Same as die()
function M.bye(bang)
  M.die(bang)
end

--- Delete config.json to reset LazyVim extras to shipped defaults (restart after)
function M.reload()
  local path = vim.g.lazyvim_json or (vim.fn.stdpath("config") .. "/config.json")
  local ok, err = os.remove(path)
  if ok then
    vim.notify("Removed " .. path .. " — restart Neovim to load shipped defaults.", vim.log.levels.INFO)
  else
    vim.notify("Could not remove " .. path .. (err and (": " .. err) or ""), vim.log.levels.ERROR)
  end
end

--- User commands (:Cheatsheet, :Theme, :Reload)
function M.setup_commands()
  vim.api.nvim_create_user_command("Cheatsheet", function()
    M.cheatsheet()
  end, { desc = "nvimGT keymap cheatsheet (NvChad)" })

  vim.api.nvim_create_user_command("Theme", function()
    M.theme()
  end, { desc = "nvimGT theme picker (base46, no catppuccin)" })

  vim.api.nvim_create_user_command("Reload", function()
    M.reload()
  end, { desc = "Delete config.json and restart to reset extras to shipped defaults" })
end

--- Register cmdline abbreviations (typing :lazy at the : prompt)
function M.setup_abbrevs()
  local abbrev = vim.cmd.cabbrev
  abbrev("lazy", "Lazy")
  abbrev("extras", "LazyExtras")
  abbrev("cheatsheet", "Cheatsheet")
  abbrev("theme", "Theme")
  abbrev("reload", "Reload")
  abbrev("die", "qa")
  abbrev("bye", "qa")
  abbrev("die!", "qa!")
  abbrev("bye!", "qa!")
end

return M
