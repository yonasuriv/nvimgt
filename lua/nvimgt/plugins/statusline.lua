-- nvimGT statusline: lualine sections themed to AstroDark
-- Left: mode, git branch, cwd | Center: filetype, path, diagnostics
-- Right: LSP progress/clients, lazyload updates, git diff | Far right: progress, location, clock
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
        color = function()
          return { fg = Snacks.util.color("Comment") }
        end,
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
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      }

      local cwd = {
        function()
          return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        color = function()
          return { fg = Snacks.util.color("Function") }
        end,
      }

      return {
        options = {
          theme = "astrodark",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = opts.options.disabled_filetypes,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            cwd,
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
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
          lualine_x = {
            lsp_progress,
            lsp_clients,
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return { fg = Snacks.util.color("Special") }
              end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              -- Read per-buffer git counts from gitsigns instead of the built-in diff source
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
          },
          -- Progress and location as a pair; clock in its own section
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = opts.extensions,
      }
    end,
  },
}
