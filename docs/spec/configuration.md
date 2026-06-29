# Configuration Guide

nvimGT builds on [lazy.nvim](https://github.com/folke/lazy.nvim) and imports [LazyVim](https://github.com/LazyVim/LazyVim) for LSP, extras, and core plugin specs (see [architecture.md](./architecture.md) and Credits in README).

## Terminology

| Term | In this repo |
|------|----------------|
| **lazy.nvim** | Plugin manager (`:lazy` or `:Lazy`) |
| **lazyload** | Deferred loading (`lazy = true`, events, commands) — nvimGT docs use this word instead of "LazyVim lazy loading" |
| **:extras** | Toggle optional language/tool packs (`:LazyExtras` also works) |
| **:cheatsheet** | NvChad keymap cheatsheet |
| **:theme** | base46 theme picker (no catppuccin) |
| **config.json** | Shipped LazyVim extras state (`vim.g.lazyvim_json` in `init.lua`) |

## How plugin specs are loaded

`lua/nvimgt/config/lazy.lua`:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "nvimgt.plugins" },
  },
})
```

Every top-level `.lua` file in `lua/nvimgt/plugins/` is imported automatically. Subdirectories are **not** scanned unless they contain an `init.lua`.

Merge rules (lazy.nvim):

- **Tables** (`opts`, `keys`) merge recursively.
- **Arrays** (`sections`, `keys`, `dependencies`) **replace** — provide the full list when overriding.
- **`opts = function(_, opts)`** receives the previous value as the second argument.

## Adding a plugin

Create `lua/nvimgt/plugins/my-plugin.lua`:

```lua
-- nvimGT: brief description of what this spec does
return {
  "author/my-plugin",
  opts = { setting = true },
  keys = {
    { "<leader>mp", "<cmd>MyPlugin<cr>", desc = "My Plugin" },
  },
}
```

## Overriding a plugin

Use the same plugin name and change only the fields you need:

```lua
return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
}
```

## Colorscheme

AstroDark via `lua/nvimgt/plugins/colorscheme.lua`. Highlight overrides live under `highlights.global`:

```lua
SnacksDashboardHeader = { fg = "#E0E0EE", bold = true },
```

Catppuccin is not used; optional catppuccin blocks existed only in archived upstream extras.

## Dashboard

Configured in `lua/nvimgt/plugins/dashboard.lua` (Snacks). Arrays like `preset.keys` and `sections` replace defaults — provide the full list.

## Statusline & tabline

- `ui.lua` — [NvChad/ui](https://github.com/NvChad/ui) with `NvChad/base46` for highlights.
- `lua/nvimgt/config/theme.lua` — `M.ui.statusline`, `M.ui.tabufline`, and base46 theme (see `:h nvui`).
- `init.lua` sets `vim.g.base46_cache` and preloads `chadrc` → `nvimgt.config.theme` for NvChad/ui; `config/lazy.lua` loads `defaults` + `statusline` cache after lazy setup.

## Keymaps

Personal bindings: `lua/nvimgt/config/keymaps.lua` (includes NvChad-adapted picker and terminal maps).

## Language / tool extras

Run `:extras` (or `:LazyExtras`) — loads from **upstream LazyVim**. Enabled extras are stored in **`config.json`** at your config root (shipped with nvimGT).

To reset extras to shipped defaults: run `:reload`, restart Neovim, or delete `config.json`.

Custom extras you author: `lua/plugins/extras/<category>/<name>.lua`.
