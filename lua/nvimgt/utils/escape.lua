-- nvimGT smart Escape — close help/floats first, then close file like tab X, else clear search
local M = {}

local EXPLORER_FT = {
  snacks_layout_box = true,
  ["neo-tree"] = true,
  NvimTree = true,
}

local SKIP_FILE_CLOSE_FT = {
  snacks_dashboard = true,
  dashboard = true,
  alpha = true,
  lazy = true,
  mason = true,
  help = true,
}

local function current()
  return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
end

local function is_floating(win)
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

--- Close help, floats, snacks panels, NvChad overlays, etc.
function M.close_aux()
  if vim.g.nvcheatsheet_displayed then
    vim.cmd("bw")
    return true
  end

  if vim.g.nvdash_displayed and vim.g.nvdash_buf then
    require("nvchad.tabufline").close_buffer(vim.g.nvdash_buf)
    return true
  end

  local win, buf = current()
  local bo = vim.bo[buf]
  local ft = bo.filetype
  local bt = bo.buftype

  if bt == "help" or ft == "help" then
    vim.cmd("close")
    return true
  end

  if bt == "quickfix" or bt == "nofile" and ft == "qf" then
    vim.cmd("close")
    return true
  end

  if EXPLORER_FT[ft] then
    if Snacks and Snacks.picker then
      for _, picker in ipairs(Snacks.picker.get({ source = "explorer" })) do
        picker:close()
      end
    end
    vim.cmd("close")
    return true
  end

  if ft:find("^snacks_") and not SKIP_FILE_CLOSE_FT[ft] then
    if is_floating(win) or vim.w[win].snacks_win then
      pcall(vim.api.nvim_win_close, win, true)
      return true
    end
    vim.cmd("close")
    return true
  end

  if is_floating(win) then
    pcall(vim.api.nvim_win_close, win, true)
    return true
  end

  if vim.w[win].snacks_win then
    pcall(vim.api.nvim_win_close, win, true)
    return true
  end

  if bt == "prompt" then
    vim.cmd("close")
    return true
  end

  if bt == "nofile" and ft ~= "" and not SKIP_FILE_CLOSE_FT[ft] then
    vim.cmd("close")
    return true
  end

  return false
end

--- Close current buffer like tabufline X (confirm save/discard)
function M.close_file()
  local _, buf = current()
  local bo = vim.bo[buf]

  if bo.buftype ~= "" and bo.buftype ~= "terminal" then
    return false
  end

  if not bo.buflisted then
    return false
  end

  if SKIP_FILE_CLOSE_FT[bo.filetype] then
    return false
  end

  if EXPLORER_FT[bo.filetype] then
    return false
  end

  require("nvchad.tabufline").close_buffer(buf)
  return true
end

function M.normal()
  if M.close_aux() then
    return
  end
  if M.close_file() then
    return
  end
  vim.cmd("noh")
  if package.loaded["lazyvim"] and LazyVim.cmp and LazyVim.cmp.actions then
    pcall(LazyVim.cmp.actions.snippet_stop)
  end
end

return M
