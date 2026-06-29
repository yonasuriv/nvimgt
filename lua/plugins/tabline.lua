-- XLVIM tabline: AstroNvim-style top buffer + tab bar, built with heirline
return {
  -- Disable LazyVim's default bufferline so we can use our own tabline
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "rebelot/heirline.nvim",
    lazy = false,
    priority = 200,
    dependencies = { "nvim-mini/mini.icons" },
    opts = function()
      local utils = require("heirline.utils")

      -- Fills space above the left sidebar and shows bold "Explorer" label
      local ExplorerOffset = {
        condition = function(self)
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_position(win)[2] == 0 then
              local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
              if vim.tbl_contains({ "snacks_layout_box", "neo-tree", "NvimTree" }, ft) then
                self.offset_win = win
                return true
              end
            end
          end
          return false
        end,
        provider = function(self)
          local width = vim.api.nvim_win_get_width(self.offset_win)
          local title = "Explorer"
          local pad = math.floor((width - vim.fn.strwidth(title)) / 2)
          return string.rep(" ", pad) .. title .. string.rep(" ", width - vim.fn.strwidth(title) - pad)
        end,
        hl = function()
          local fill = utils.get_highlight("TabLineFill")
          return { fg = fill.fg, bg = fill.bg, bold = true }
        end,
      }

      -- Clickable buffer tab: file icon, name, modified indicator, close button
      local BufferTab = {
        init = function(self)
          self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
          if self.filename == "" then
            self.filename = "Untitled"
          end
          self.is_modified = vim.bo[self.bufnr].modified
          local icon, hl = require("mini.icons").get("file", self.filename)
          self.icon = icon or ""
          self.icon_hl = hl or "MiniIconsGrey"
        end,
        {
          provider = function(self)
            return " " .. self.icon .. " "
          end,
          hl = function(self)
            return self.is_active and self.icon_hl or "TabLine"
          end,
        },
        {
          provider = function(self)
            return self.filename .. " "
          end,
          hl = function(self)
            return self.is_active and "TabLineSel" or "TabLine"
          end,
        },
        {
          provider = function(self)
            return self.is_modified and "● " or ""
          end,
          hl = function(self)
            return self.is_active and "TabLineSel" or "TabLine"
          end,
        },
        {
          provider = "󰅖 ",
          hl = function(self)
            if self.is_active then
              local c = utils.get_highlight("DiagnosticError")
              return { fg = c.fg and string.format("#%06x", c.fg) or "#FF5555" }
            end
            return "TabLine"
          end,
          on_click = {
            callback = function(_, minwid, _, button)
              if button == "l" then
                Snacks.bufdelete(minwid)
              end
            end,
            minwid = function(self)
              return self.bufnr
            end,
            name = "xlvim_tabline_close_buf",
          },
        },
        hl = function(self)
          return self.is_active and "TabLineSel" or "TabLine"
        end,
        on_click = {
          callback = function(_, minwid, _, button)
            if button == "l" then
              vim.api.nvim_win_set_buf(0, minwid)
            end
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "xlvim_tabline_switch_buf",
        },
      }

      -- Tab-page indicator
      local Tab = {
        provider = function(self)
          return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
        end,
        hl = function(self)
          return self.is_active and "TabLineSel" or "TabLine"
        end,
      }

      return {
        tabline = {
          ExplorerOffset,
          utils.make_buflist(
            BufferTab,
            { provider = " < ", hl = "TabLineFill" },
            { provider = " > ", hl = "TabLineFill" }
          ),
          { provider = "%=", hl = "TabLineFill" },
          {
            condition = function()
              return #vim.api.nvim_list_tabpages() > 1
            end,
            utils.make_tablist(Tab),
          },
        },
      }
    end,
    config = function(_, opts)
      require("heirline").setup(opts)
    end,
  },
}
