-- nvimGT theme config
-- See :h nvui and https://github.com/NvChad/ui/blob/main/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "astrodark",
  transparency = true,
  theme_toggle = { "astrodark", "astrolight" },
  -- LazyVim uses blink + snacks; skip NvChad highlight packs we do not ship
  excluded = { "cmp", "telescope" },
  integrations = { "blink" },
  hl_override = {
    SnacksDashboardHeader = { fg = "#E0E0EE", bold = true },
    SnacksDashboardIcon = { fg = "#FF838B" },
    SnacksDashboardDesc = { fg = "#9B9FA9" },
    SnacksDashboardKey = { fg = "#FF838B" },
    SnacksDashboardFooter = { fg = "#595C66" },
    SnacksDashboardSpecial = { fg = "#595C66" },
    -- Snacks picker: underline cursor row instead of solid block (mouse + keyboard)
    SnacksPickerListCursorLine = { bg = "NONE", underline = true },
  },
}

M.ui = {
  statusline = {
    enabled = true,
    theme = "default",
    separator_style = "default",
  },

  tabufline = {
    enabled = true,
    lazyload = false,
    bufwidth = 28,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = {
      treeOffset = function()
        local api = vim.api
        local strep = string.rep
        for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
          local ft = vim.bo[api.nvim_win_get_buf(win)].filetype
          if vim.tbl_contains({ "snacks_layout_box", "neo-tree", "NvimTree" }, ft) then
            local w = api.nvim_win_get_width(win)
            if w > 0 then
              return "%#NvimTreeNormal#" .. strep(" ", w) .. "%#NvimTreeWinSeparator#" .. "│"
            end
          end
        end
        return ""
      end,
      buffers = function()
        return require("nvimgt.utils.tabufline").buffers()
      end,
      tabs = function()
        return require("nvimgt.utils.tabufline").tabs() -- workspaces UI
      end,
      btns = function()
        return require("nvimgt.utils.tabufline").btns()
      end,
    },
  },
}

M.cheatsheet = {
  theme = "grid",
  excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

return M
