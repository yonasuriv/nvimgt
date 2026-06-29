-- nvimGT theme picker — wraps NvChad/themes, excludes catppuccin variants
local M = {}

local EXCLUDED = { catppuccin = true }

local function filtered_themes()
  local themes = require("nvchad.utils").list_themes()
  return vim.tbl_filter(function(name)
    return not EXCLUDED[name] and not name:find("^catppuccin")
  end, themes)
end

function M.open()
  package.loaded["nvchad.themes.state"] = nil
  local state = require("nvchad.themes.state")
  state.val = filtered_themes()
  state.themes_shown = state.val
  require("nvchad.themes").open()
end

return M
