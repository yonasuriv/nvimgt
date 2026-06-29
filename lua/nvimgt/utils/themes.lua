-- nvimGT theme picker — wraps NvChad/themes, excludes catppuccin variants
local M = {}

local api = vim.api

local EXCLUDED = { catppuccin = true }

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

local function cleanup_au()
  cancel_cmp()
  vim.cmd.stopinsert()
  if cleanup_augroup then
    pcall(api.nvim_del_augroup_by_id, cleanup_augroup)
    cleanup_augroup = nil
  end
end

local function theme_state()
  return package.loaded["nvchad.themes.state"] and require("nvchad.themes.state") or nil
end

--- Close picker floats; revert theme unless confirmed
local function close_picker()
  local state = theme_state()
  local confirmed = state and state.confirmed

  cancel_cmp()
  vim.cmd.stopinsert()

  if state then
    for _, win in ipairs({ state.input_win, state.win }) do
      if win and api.nvim_win_is_valid(win) then
        pcall(api.nvim_win_close, win, true)
      end
    end
    for _, buf in ipairs({ state.input_buf, state.buf }) do
      if buf and api.nvim_buf_is_valid(buf) then
        pcall(api.nvim_buf_delete, buf, { force = true })
      end
    end
  end

  if state and not confirmed then
    pcall(function()
      require("plenary.reload").reload_module("chadrc")
      local theme = require("chadrc").base46.theme
      require("nvchad.themes.utils").reload_theme(theme)
    end)
  end

  package.loaded["nvchad.themes.state"] = nil
  pcall(function()
    require("plenary.reload").reload_module("nvchad.themes")
  end)

  cleanup_au()
end

local function confirm_theme()
  local state = theme_state()
  if not state or #state.themes_shown == 0 then
    return
  end

  state.confirmed = true
  local name = state.themes_shown[state.index]
  package.loaded.chadrc = nil
  local old_theme = require("chadrc").base46.theme

  require("nvchad.utils").replace_word('"' .. old_theme .. '"', '"' .. name .. '"')
  close_picker()
end

local function cancel_picker()
  local state = theme_state()
  if state then
    state.confirmed = false
  end
  close_picker()
end

--- volt.close() feeds "q" in insert mode; close mapping is normal-mode only
local function hook_volt_close()
  local volt_utils = require("volt.utils")
  if volt_utils._nvimgt_hooked then
    return
  end
  volt_utils._nvimgt_hooked = true

  local orig_close = volt_utils.close
  volt_utils.close = function(val)
    local state = theme_state()
    if state and state.input_win and api.nvim_win_is_valid(state.input_win) then
      pcall(api.nvim_win_close, state.input_win, true)
    end
    orig_close(val)
    volt_utils.close = orig_close
    volt_utils._nvimgt_hooked = nil
    cleanup_au()
  end
end

function M.open()
  cancel_cmp()
  hook_volt_close()

  cleanup_augroup = api.nvim_create_augroup("NvimgtThemePicker", { clear = true })
  api.nvim_create_autocmd({ "VimLeave", "WinClosed" }, {
    group = cleanup_augroup,
    callback = function(ev)
      if ev.event == "WinClosed" then
        local state = theme_state()
        if state and (ev.match == state.input_win or ev.match == state.win) then
          vim.schedule(cleanup_au)
        end
        return
      end
      cleanup_au()
    end,
  })

  package.loaded["nvchad.themes.state"] = nil
  local state = require("nvchad.themes.state")
  state.val = filtered_themes()
  state.themes_shown = state.val
  state.confirmed = false

  require("nvchad.themes").open({
    border = false,
    mappings = function(input_buf)
      api.nvim_create_autocmd({ "InsertEnter", "TextChangedI" }, {
        buffer = input_buf,
        callback = cancel_cmp,
      })

      -- NvChad maps <CR> then volt.close() which fails in insert mode; override last
      vim.keymap.set({ "i", "n" }, "<CR>", confirm_theme, { buffer = input_buf, nowait = true })
      vim.keymap.set("i", "<Esc>", cancel_picker, { buffer = input_buf, nowait = true })
    end,
  })
end

return M
