-- nvimGT theme picker — wraps NvChad/themes, excludes catppuccin variants
local M = {}

local api = vim.api

local EXCLUDED = { catppuccin = true }

local backdrop_win = nil
local cleanup_augroup = nil

local function filtered_themes()
  local themes = require("nvchad.utils").list_themes()
  return vim.tbl_filter(function(name)
    return not EXCLUDED[name] and not name:find("^catppuccin")
  end, themes)
end

local function cancel_cmp()
  pcall(function()
    require("blink.cmp").cancel()
  end)
end

local function close_backdrop()
  if backdrop_win and api.nvim_win_is_valid(backdrop_win) then
    api.nvim_win_close(backdrop_win, true)
  end
  backdrop_win = nil
end

local function open_backdrop()
  close_backdrop()
  api.nvim_set_hl(0, "NvimgtOverlay", { bg = "#000000", fg = "#000000" })
  local buf = api.nvim_create_buf(false, true)
  backdrop_win = api.nvim_open_win(buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = vim.o.lines,
    row = 0,
    col = 0,
    style = "minimal",
    focusable = false,
    zindex = 1,
  })
  vim.wo[backdrop_win].winhl = "Normal:NvimgtOverlay"
  api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
end

local function cleanup()
  cancel_cmp()
  close_backdrop()
  vim.cmd.stopinsert()
  if cleanup_augroup then
    pcall(api.nvim_del_augroup_by_id, cleanup_augroup)
    cleanup_augroup = nil
  end
end

local function hook_volt_close()
  local volt_utils = require("volt.utils")
  local orig = volt_utils.close
  volt_utils.close = function(val)
    cleanup()
    volt_utils.close = orig
    return orig(val)
  end
end

function M.open()
  cancel_cmp()
  open_backdrop()
  hook_volt_close()

  cleanup_augroup = api.nvim_create_augroup("NvimgtThemePicker", { clear = true })
  api.nvim_create_autocmd({ "VimLeave", "WinClosed" }, {
    group = cleanup_augroup,
    callback = function(ev)
      if ev.event == "WinClosed" then
        local state = package.loaded["nvchad.themes.state"] and require("nvchad.themes.state")
        if state and (ev.match == state.input_win or ev.match == state.win) then
          vim.schedule(cleanup)
        end
        return
      end
      cleanup()
    end,
  })

  package.loaded["nvchad.themes.state"] = nil
  local state = require("nvchad.themes.state")
  state.val = filtered_themes()
  state.themes_shown = state.val

  require("nvchad.themes").open({
    border = false,
    mappings = function(input_buf)
      api.nvim_create_autocmd({ "InsertEnter", "TextChangedI" }, {
        buffer = input_buf,
        callback = cancel_cmp,
      })
    end,
  })
end

return M
