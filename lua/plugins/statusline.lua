-- XLVIM statusline: NvChad-style layout on top of LazyVim's lualine
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      local lsp_progress = {
        function()
          return vim.lsp.status()
        end,
        cond = function()
          return vim.lsp.status() ~= ""
        end,
        color = { fg = Snacks.util.color("Comment") },
      }

      local lsp_clients = {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return "󰌘 " .. table.concat(names, ", ")
        end,
        color = { fg = Snacks.util.color("Special") },
      }

      local cwd = {
        function()
          return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        color = { fg = Snacks.util.color("Function") },
      }

      return {
        options = {
          theme = "astrodark",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = opts.options.disabled_filetypes,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 0,
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_x = {
            lsp_progress,
            lsp_clients,
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = Snacks.util.color("Special") },
            },
          },
          lualine_y = { cwd },
          lualine_z = {
            { "location", separator = "", padding = { left = 1, right = 0 } },
            { "progress", padding = { left = 0, right = 1 } },
          },
        },
        extensions = opts.extensions,
      }
    end,
  },
}
