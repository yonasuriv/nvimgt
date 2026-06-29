# Configuration Guide

XLVIM is built on [LazyVim](https://github.com/LazyVim/LazyVim), so the full LazyVim configuration model applies. This guide covers XLVIM-specific patterns and the most common customization tasks.

## How Plugin Specs Are Loaded

`lua/config/lazy.lua` sets up two spec sources:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },  -- LazyVim defaults
    { import = "plugins" },                               -- XLVIM overrides
  },
  ...
})
```

Every `.lua` file in `lua/plugins/` is imported automatically. Files are merged on top of LazyVim's specs using lazy.nvim's deep-merge rules:

- **Tables** (opts, keys, etc.) are merged recursively.
- **Arrays** (like `sections`, `keys`, or `dependencies`) are **replaced**, not merged — provide the full list if you override one.
- **Functions** (like `opts = function(_, opts)`) receive the previous value as the second argument, letting you extend it.

## Adding a Plugin

Create a file in `lua/plugins/` returning a lazy.nvim spec:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/my-plugin",
  opts = {
    setting = true,
  },
  keys = {
    { "<leader>mp", "<cmd>MyPlugin<cr>", desc = "My Plugin" },
  },
}
```

## Overriding a LazyVim Plugin

Use the same plugin name and set only the fields you want to change:

```lua
-- lua/plugins/overrides.lua
return {
  -- Disable LazyVim's default dashboard
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },

  -- Change a default option in telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
      },
    },
  },
}
```

## Colorscheme and Highlight Overrides

Highlight group overrides live in `lua/plugins/colorscheme.lua` under `highlights.global`. These are applied on top of AstroDark without modifying the theme source:

```lua
-- lua/plugins/colorscheme.lua
return {
  {
    "AstroNvim/astrotheme",
    opts = {
      highlights = {
        global = {
          -- Any Neovim highlight group can go here
          Comment = { fg = "#7C8190", italic = true },
          -- Dashboard colors
          SnacksDashboardHeader  = { fg = "#E0E0EE", bold = true },
          SnacksDashboardIcon    = { fg = "#FF838B" },
        },
      },
    },
  },
}
```

To target only AstroDark (and not other astrotheme variants), use `highlights.astrodark` instead of `highlights.global`.

## Dashboard

The dashboard is configured in `lua/plugins/dashboard.lua` via `folke/snacks.nvim`. Key areas:

### Changing the Header

Replace the `preset.header` string with any multi-line ASCII art. All lines should be padded to the same **display column width** (not byte length) so they center correctly:

```lua
opts = {
  dashboard = {
    preset = {
      header = [[
Line one padded to N cols
Line two padded to N cols
]],
    },
  },
}
```

Block-drawing characters like `█` (U+2588) are single display-column wide despite being 3 UTF-8 bytes each. Use a display-width calculator when padding.

### Changing Menu Items

Override `preset.keys` with the full list (arrays replace, not merge):

```lua
preset = {
  keys = {
    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
    -- ... add/remove/reorder entries
  },
}
```

Icons must be valid Nerd Font codepoints. The safest way to include them is to copy the bytes directly from a known-good source rather than typing them in an editor that may silently strip them.

### Customizing the Startup Line

The startup line is defined as a function in `sections` that returns a raw text item:

```lua
sections = {
  { section = "header" },
  { section = "keys", gap = 1, padding = 1 },
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
```

`hl = "footer"` maps to `SnacksDashboardFooter`, which is set to a dimmed grey in `colorscheme.lua`.

## Statusline

`lua/plugins/statusline.lua` configures lualine. The `opts = function(_, opts)` form receives LazyVim's default opts so you can extend rather than replace:

```lua
opts = function(_, opts)
  -- Modify opts.sections, opts.options, etc.
  opts.options.theme = "astrodark"
  table.insert(opts.sections.lualine_c, { "my_component" })
  return opts
end,
```

Colors in statusline components use `Snacks.util.color("HlGroup")`, which must be wrapped in a `function()` so it evaluates at render time, not at setup time.

## Tabline

`lua/plugins/tabline.lua` builds the tabline with heirline. The main components are:

| Component | Purpose |
|---|---|
| `ExplorerOffset` | Fills the tabline space above the sidebar with a bold **Explorer** label |
| `BufferTab` | One entry per listed buffer: icon, name, modified dot, red close button |
| `Tab` | Tab-page number, shown only when multiple tabs exist |

Heirline highlight values must be either a **highlight group name** (string) or a **table with hex/integer `fg`/`bg` fields**. Passing a group name as the value of `fg` is invalid and will cause a render error.

## Adding Language Support

XLVIM inherits LazyVim's extras system. Run `:LazyExtras` to browse available language and tool packs (LSP, formatter, linter, treesitter) and toggle them on. Enabled extras are recorded in `lazyvim.json`.

## Keymaps

All of LazyVim's default keymaps are available. Personal additions go in `lua/config/keymaps.lua`:

```lua
-- lua/config/keymaps.lua
local map = vim.keymap.set

map("n", "<leader>xx", function() print("hello") end, { desc = "Hello" })
```

LazyVim's keymaps can be disabled by setting them to `false` in the same file:

```lua
vim.keymap.del("n", "<leader>bd")  -- remove a default binding
```
