-- XLVIM tabline: AstroNvim-style top buffer + tab bar, built with heirline
return {
  -- Disable LazyVim's default bufferline so we can use our own tabline
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    opts = function()
      local utils = require("heirline.utils")

      -- Clickable buffer tab: file icon, name, modified indicator, close button
      local BufferTab = {
        init = function(self)
          self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
          if self.filename == "" then
            self.filename = "[No Name]"
          end
          self.is_modified = vim.bo[self.bufnr].modified
          local icon, hl = require("mini.icons").get("file", self.filename)
          self.icon = icon or ""
          self.icon_hl = hl or "MiniIconsGrey"
        end,
        {
          provider = function(self)
            return " " .. self.icon .. " "
          end,
          hl = function(self)
            return self.is_active and { fg = self.icon_hl } or "TabLine"
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
          provider = "󰅖",
          hl = function(self)
            return self.is_active and "TabLineSel" or "TabLine"
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
          -- Buffer list with overflow markers
          utils.make_buflist(
            BufferTab,
            { provider = "﬌", hl = "TabLineFill" },
            { provider = "﬍", hl = "TabLineFill" }
          ),
          -- Fill the remaining space
          { provider = "%=", hl = "TabLineFill" },
          -- Tab-page numbers, only shown when more than one tab exists
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
