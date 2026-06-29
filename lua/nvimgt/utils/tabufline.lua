-- nvimGT tabufline — workspaces, new-file (+), Untitled names, quit-with-confirm
local M = {}

local btn = function(...)
  return require("nvchad.tabufline.utils").btn(...)
end

local txt = function(...)
  return require("nvchad.tabufline.utils").txt(...)
end

--- Listed buffers in this tabpage with no path, stable order
function M.list_unnamed_bufs()
  local unnamed = {}
  for _, b in ipairs(vim.t.bufs or {}) do
    if vim.api.nvim_buf_is_valid(b) and vim.api.nvim_buf_get_name(b) == "" then
      unnamed[#unnamed + 1] = b
    end
  end
  table.sort(unnamed)
  return unnamed
end

--- Untitled, Untitled(1), Untitled(2), … for buffers without a path
function M.untitled_name(bufnr)
  for i, b in ipairs(M.list_unnamed_bufs()) do
    if b == bufnr then
      return i == 1 and "Untitled" or ("Untitled(" .. (i - 1) .. ")")
    end
  end
  return "Untitled"
end

function M.display_name(bufnr, index)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return M.untitled_name(bufnr)
  end
  local tail = path:match "([^/\\]+)[/\\]*$"
  if not tail or tail == "" then
    return M.untitled_name(bufnr)
  end
  for i2, nr2 in ipairs(vim.t.bufs) do
    local other = vim.api.nvim_buf_get_name(nr2)
    local other_tail = other:match "([^/\\]+)[/\\]*$"
    if index ~= i2 and other_tail == tail then
      return vim.fn.fnamemodify(path, ":h:t") .. "/" .. tail
    end
  end
  return tail
end

function M.resolve_save_path(input)
  local path = vim.fn.fnamemodify(input, ":p")
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
  return path
end

function M.style_buf(nr, i, w)
  local api = vim.api
  local get_opt = api.nvim_get_option_value
  local strep = string.rep
  local cur_buf = api.nvim_get_current_buf

  local function new_hl(group1, group2)
    local fg = api.nvim_get_hl(0, { name = group1 }).fg
    local bg = api.nvim_get_hl(0, { name = "Tb" .. group2 }).bg
    api.nvim_set_hl(0, group1 .. group2, { fg = fg, bg = bg })
    return "%#" .. group1 .. group2 .. "#"
  end

  local icon = "󰈚 "
  local is_curbuf = cur_buf == nr
  local tb_hl = "BufO" .. (is_curbuf and "n" or "ff")
  local icon_hl = new_hl("DevIconDefault", tb_hl)

  local name = M.display_name(nr, i)
  local devicon, devicon_hl = require("nvim-web-devicons").get_icon(name)
  if devicon then
    icon = " " .. devicon .. " "
    icon_hl = new_hl(devicon_hl, tb_hl)
  end

  local pad = math.floor((w - #name - 5) / 2)
  pad = pad <= 0 and 1 or pad

  local maxname_len = w - 5
  name = string.sub(name, 1, maxname_len - 2) .. (#name > maxname_len and ".." or "")
  name = txt(name, tb_hl)
  name = strep(" ", pad - 1) .. (icon_hl .. icon .. name) .. strep(" ", pad - 1)
  name = btn(name, nil, "GoToBuf", nr)

  local mod = get_opt("mod", { buf = nr })
  local close_btn
  if is_curbuf then
    local mod_mark = mod and txt(" ●", "BufOnModified") or ""
    close_btn = mod_mark .. btn(" 󰅖 ", "BufOnClose", "KillBuf", nr)
  elseif mod then
    close_btn = txt("  ", "BufOffModified")
  else
    close_btn = btn(" 󰅖 ", "BufOffClose", "KillBuf", nr)
  end

  return txt(name .. close_btn, "BufO" .. (is_curbuf and "n" or "ff"))
end

function M.buffers()
  local opts = require("nvconfig").ui.tabufline
  local buffers = {}
  local has_current = false
  local cur_buf = vim.api.nvim_get_current_buf
  local new_file_btn = btn(" + ", "TabNewBtn", "NewBuf")

  vim.t.bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, vim.t.bufs)

  local function available_space()
    local str = new_file_btn
    local cfg = require("nvconfig").ui.tabufline
    for _, key in ipairs(cfg.order) do
      if key ~= "buffers" then
        local mod = cfg.modules and cfg.modules[key]
        if mod then
          str = str .. mod()
        end
      end
    end
    local evaluated = vim.api.nvim_eval_statusline(str, { use_tabline = true })
    return vim.o.columns - evaluated.width
  end

  local space = available_space()

  for i, nr in ipairs(vim.t.bufs) do
    if ((#buffers + 1) * opts.bufwidth) > space then
      if has_current then
        break
      end
      table.remove(buffers, 1)
    end

    has_current = cur_buf == nr or has_current
    buffers[#buffers + 1] = M.style_buf(nr, i, opts.bufwidth)
  end

  return table.concat(buffers) .. new_file_btn .. txt("%=", "Fill")
end

--- Workspaces (Neovim tabpages): new workspace + WORKSPACES toggle + tab numbers
function M.tabs()
  local g = vim.g
  local fn = vim.fn
  local tabs = fn.tabpagenr("$")

  g.TbTabsToggled = g.TbTabsToggled or 0

  local new_ws = btn(" 󰐕 ", "TabNewBtn", "NewTab")
  local ws_toggle = btn(" WORKSPACES ", "TabTitle", "ToggleTabs")
  local small_btn = btn(" 󰅁 ", "TabTitle", "ToggleTabs")
  local toggle = g.TbTabsToggled == 1 and small_btn or ws_toggle

  local result = ""
  local show_tabs = tabs > 1 or g.TbTabsToggled == 1
  if show_tabs then
    for nr = 1, tabs do
      local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
      result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end
  end

  return new_ws .. toggle .. result
end

function M.btns()
  local toggle_theme = btn(vim.g.toggle_theme_icon or "   ", "ThemeToggleBtn", "Toggle_theme")
  local quit = btn(" 󰅖 ", "CloseAllBufsBtn", "CloseAllBufs")
  return toggle_theme .. quit
end

function M.new_file()
  vim.cmd("enew")
  vim.cmd("redrawtabline")
end

function M.setup()
  vim.cmd [[
    function! TbCloseAllBufs(a,b,c,d)
      call luaeval('require("nvimgt.utils.commands").confirm_quit()')
    endfunction
    function! TbNewBuf(a,b,c,d)
      call luaeval('require("nvimgt.utils.tabufline").new_file()')
    endfunction
  ]]

  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("nvimgt_tabufline_clear_winbar", { clear = true }),
    callback = function()
      if vim.wo.winbar ~= "" then
        vim.wo.winbar = ""
      end
    end,
  })

  local untitled = vim.api.nvim_create_augroup("nvimgt_untitled", { clear = true })

  vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
    group = untitled,
    callback = function()
      vim.schedule(function()
        pcall(vim.cmd, "redrawtabline")
      end)
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = untitled,
    callback = function(args)
      if vim.api.nvim_buf_get_name(args.buf) ~= "" then
        return
      end
      local default = M.untitled_name(args.buf)
      local input = vim.ui.input({ prompt = "Save as: ", default = default })
      if not input or input == "" then
        error("Save cancelled", 0)
      end
      vim.api.nvim_buf_set_name(args.buf, M.resolve_save_path(input))
    end,
  })
end

return M
