# XLVIM Design Spec

```text
          d8b            d8,
          88P           `8P
         d88
?88,  88P888  ?88   d8P  88b  88bd8b,d88b
 `?8bd8P'?88  d88  d8P'  88P  88P'`?8P'?8b
 d8P?8b,  88b ?8b ,88'  d88  d88  d88  88P
d8P' `?8b  88b`?888P'  d88' d88' d88'  88b
```

**Goal:** Build a personal Neovim configuration repo named **XLVIM** that uses **LazyVim** as the plugin distribution, applies the **AstroNvim AstroDark** colorscheme, adds an **AstroNvim-style top buffer/tab bar**, and restyles the bottom statusline to match **NvChad**.

## Architecture

- Base = LazyVim starter layout (`init.lua` → `config.lazy` → `lazyvim.plugins` + local `lua/plugins/`).
- Colors = `AstroNvim/astrotheme` with palette `astrodark`, configured as LazyVim’s active colorscheme.
- Bottom bar = keep LazyVim’s `lualine.nvim`, but replace its sections with a NvChad-like layout and use the `astrodark` lualine theme.
- Top bar = disable LazyVim’s `bufferline.nvim` and implement a custom tabline with `heirline.nvim` that shows:
  - a clickable buffer list (file icon, name, modified indicator, close button)
  - a tab-page list when more than one tab exists
  - AstroNvim-style highlight groups (`TabLine`, `TabLineSel`, `TabLineFill`).

## Component Choices

| Feature | Plugin / Mechanism | Source Inspiration |
|---|---|---|
| Plugin manager | `lazy.nvim` (LazyVim) | LazyVim starter |
| Colorscheme | `AstroNvim/astrotheme` → `astrodark` | AstroNvim |
| Bottom statusline | `lualine.nvim` re-themed/re-sectioned | NvChad default statusline |
| Top buffer/tab bar | `heirline.nvim` custom tabline | AstroNvim tabline layout |

## File Layout

```
xlvim/
├── init.lua
├── README.md
├── stylua.toml
├── .gitignore
├── LICENSE
└── lua/
    ├── config/
    │   ├── lazy.lua      # bootstrap lazy.nvim, import LazyVim + local plugins
    │   ├── options.lua   # XLVIM options (global statusline, etc.)
    │   ├── keymaps.lua   # user keymaps
    │   └── autocmds.lua  # user autocommands
    └── plugins/
        ├── colorscheme.lua  # astrodark + LazyVim colorscheme override
        ├── statusline.lua   # NvChad-style lualine
        └── tabline.lua      # AstroNvim-style heirline tabline
```

## Key Decisions

1. **No AstroNvim or NvChad core plugins are installed.** We only borrow their visual ideas. This avoids distribution conflicts (e.g., `astrocore` vs LazyVim options/keymaps).
2. **`lualine` is kept instead of porting NvChad statusline to `heirline`.** It integrates cleanly with LazyVim and already supports the `astrodark` theme, while still allowing a NvChad-like section order.
3. **`bufferline.nvim` is disabled.** A single `heirline` tabline gives us both buffers and tab pages in one bar, matching AstroNvim.
4. **All branding/comments in the local plugin files use XLVIM**, not LazyVim/AstroNvim/NvChad.

## Success Criteria

- `nvim` starts without errors.
- Colorscheme is `astrodark`.
- Bottom statusline shows: mode, branch, git diff, diagnostics, filename, LSP progress, LSP clients, cwd, cursor position.
- Top tabline shows clickable buffers and tab numbers when multiple tabs exist.
