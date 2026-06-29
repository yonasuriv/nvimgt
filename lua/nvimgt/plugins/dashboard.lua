-- nvimGT dashboard: custom header, colors, startup line, and tweaks
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
                         ███                       █████████  ███████████
                        ░░░                       ███░░░░░███░█░░░███░░░█
 ████████   █████ █████ ████  █████████████      ███     ░░░ ░   ░███  ░
░░███░░███ ░░███ ░░███ ░░███ ░░███░░███░░███    ░███             ░███
 ░███ ░███  ░███  ░███  ░███  ░███ ░███ ░███    ░███    █████    ░███
 ░███ ░███  ░░███ ███   ░███  ░███ ░███ ░███    ░░███  ░░███     ░███
 ████ █████  ░░█████    █████ █████░███ █████    ░░█████████     █████
░░░░ ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░      ░░░░░░░░░     ░░░░░
]],
          -- stylua: ignore
          keys = {
            
            { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":lua require('nvimgt.util.commands').lazy()" },
            { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "x", desc = "Extras",          action = ":lua require('nvimgt.util.commands').extras()" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "q", desc = "Quit",            action = ":lua require('nvimgt.util.commands').die()" },
          },
        },
        -- Replace the default sections so we can customize the startup line
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          -- Custom startup: "X/Y plugins loaded in XX.ZZ ms" -- no icon, all dimmed
          function()
            local stats = require("lazy.stats").stats()
            local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
            return {
              padding = 1,
              align = "center",
              text = {
                { stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. " ms", hl = "footer" },
              },
            }
          end,
        },
        -- Large scrolloff centers content and prevents any visual scrollbar
        wo = { scrolloff = 999 },
      },
      -- Remove "Explorer" title from the sidebar panel -- the tabline offset already shows it
      picker = {
        sources = {
          explorer = {
            title = "",
          },
        },
      },
    },
  },
}
