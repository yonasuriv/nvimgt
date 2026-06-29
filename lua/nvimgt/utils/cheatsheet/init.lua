-- nvimGT cheatsheet — fullscreen float so grid columns fit the visible area
local M = {}

local api = vim.api

local float_win = nil

local function renderer()
  local theme = require("nvconfig").cheatsheet.theme or "grid"
  if theme == "grid" then
    return require("nvimgt.utils.cheatsheet.grid")
  end
  return require("nvchad.cheatsheet." .. theme)
end

function M.close()
  if float_win and api.nvim_win_is_valid(float_win) then
    api.nvim_win_close(float_win, true)
  end
  float_win = nil
  vim.g.nvcheatsheet_displayed = false
end

function M.open()
  if vim.g.nvcheatsheet_displayed then
    M.close()
    return
  end

  package.loaded["nvchad.cheatsheet.grid"] = require("nvimgt.utils.cheatsheet.grid")

  local width = vim.o.columns
  local height = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 0 and 0 or 1)

  local buf = api.nvim_create_buf(false, true)
  float_win = api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = 0,
    col = 0,
    style = "minimal",
    border = "none",
    zindex = 200,
  })

  vim.wo[float_win].winhl = "Normal:Normal"
  vim.wo[float_win].number = false
  vim.wo[float_win].relativenumber = false
  vim.wo[float_win].signcolumn = "no"

  renderer()(buf, float_win, "open")

  local close = function()
    M.close()
  end
  vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
  vim.keymap.set("n", " ", close, { buffer = buf, nowait = true })

  api.nvim_create_autocmd({ "WinClosed", "BufWinLeave" }, {
    buffer = buf,
    once = true,
    callback = function()
      float_win = nil
      vim.g.nvcheatsheet_displayed = false
    end,
  })
end

function M.toggle()
  if vim.g.nvcheatsheet_displayed then
    M.close()
  else
    M.open()
  end
end

return M
