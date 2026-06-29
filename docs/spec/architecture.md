# nvimGT Architecture

## Names

| Term | Meaning |
|------|---------|
| **nvimGT** | This Neovim configuration distribution |
| **lazy.nvim** | Plugin manager by [folke](https://github.com/folke/lazy.nvim) — bootstrapped in `config/lazy.lua` |
| **lazyload** | nvimGT term for **deferred plugin loading** (`lazy = true` in specs, event/cmd/keys triggers) |
| **LazyVim** | Upstream distribution layer (LSP, extras, core specs) — credited in README; nvimGT branding in UI |

> **Commands:** `:lazy`, `:extras`, `:reload`, `:die`, `:bye` — see `lua/nvimgt/utils/commands.lua`. Typed aliases use cmdline abbreviations; dashboard uses the same Lua helpers. `:Lazy` / `:LazyExtras` remain valid upstream names.

## Boot sequence

```
init.lua
  ├─ package.preload["config.options|keymaps|autocmds"] → nvimgt.config.*
  └─ require("nvimgt.config.lazy")
       └─ require("lazy").setup({
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            { import = "nvimgt.plugins" },
          })
```

LazyVim's init loads `config.options`, then plugins, then `config.keymaps` and `config.autocmds` via the preload shim.

## Folder layout

```
lua/nvimgt/
├── config/          # vim.opt, keymaps, autocmds, lazy bootstrap ONLY
├── plugins/         # lazy.nvim specs (top-level .lua files only)
├── utils/           # commands and other utilities
├── health.lua       # :checkhealth nvimgt
└── types.lua        # LuaLS @meta (not runtime)

lua/plugins/extras/  # (optional) User extras discovered by :LazyExtras

reference/lazyvim/   # Upstream snapshots — NOT loaded
```

## What nvimGT owns

| File | Role |
|------|------|
| `plugins/dashboard.lua` | Snacks startup screen |
| `plugins/nvchad-ui.lua` | NvChad/ui statusline + tabufline (disables lualine/heirline/bufferline) |
| `plugins/colorscheme.lua` | Disables astrotheme; loads base46 via chadrc |
| `lua/chadrc.lua` | NvChad UI + base46 theme (astrodark default) |
| `lua/themes/` | Custom base46 themes (`astrodark`, `astrolight`) |
| `plugins/completion.lua` | blink.cmp documentation popup |
| `plugins/gitsigns.lua` | Gutter icon overrides (NvChad salvage) |
| `plugins/mason.lua` | Mason UI tweaks (NvChad salvage) |
| `plugins/treesitter.lua` | Core grammar ensure_installed |
| `config/keymaps.lua` | Personal + NvChad-adapted bindings |

Everything else (LSP, formatting, linting, default pickers) comes from the LazyVim import until the lazyload migration replaces it.

## Extras workflow

1. Run `:extras` inside nvimGT.
2. Toggle language/tool packs — state saved to **`config.json`** (`vim.g.lazyvim_json` in `init.lua`).
3. Reset to shipped defaults: `:reload` then restart.