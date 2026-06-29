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

--- Quit all windows (alias for :qa). Pass true for force quit (:qa!).
function M.die(bang)
  vim.cmd("qa" .. (bang and "!" or ""))
end

--- Same as die()
function M.bye(bang)
  M.die(bang)
end

--- Register cmdline abbreviations (typing :lazy at the : prompt)
function M.setup_abbrevs()
  local abbrev = vim.cmd.cabbrev
  -- Expand to upstream command names so subcommands work: :lazy load foo → :Lazy load foo
  abbrev("lazy", "Lazy")
  abbrev("extras", "LazyExtras")
  abbrev("die", "qa")
  abbrev("bye", "qa")
  abbrev("die!", "qa!")
  abbrev("bye!", "qa!")
end

return M
