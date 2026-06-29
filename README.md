<div align="center" id="madewithlua">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/xlvim-dark.png">
    <source media="(prefers-color-scheme: light)" srcset=".github/assets/xlvim-white.png">
    <img src=".github/assets/xlvim-dark.png" alt="XLVIM" width="110" height="100">
  </picture>
</div>

<h1 align="center">e<b>X</b>tended Line-editor with Visual Improved Mode</h1>

<p align="center">
  A Neovim configuration that fuses the best of
  <a href="https://github.com/LazyVim/LazyVim">LazyVim</a>,
  <a href="https://github.com/AstroNvim/AstroNvim">AstroNvim</a>, and
  <a href="https://github.com/NvChad/NvChad">NvChad</a> into one cohesive setup.
</p>

---

## What XLVIM Is

XLVIM is a curated Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim) as its plugin foundation, extended with the visual identity and UX elements of AstroNvim and NvChad:

| Source | What XLVIM takes from it |
|---|---|
| **LazyVim** | Plugin manager, LSP/formatter/linter wiring, treesitter, all extras |
| **AstroNvim** | AstroDark colorscheme, heirline-based buffer/tab bar |
| **NvChad** | Statusline layout and section order |

None of AstroNvim's or NvChad's core systems are installed — XLVIM only borrows their visual ideas, avoiding distribution conflicts.

## Requirements

- **Neovim** ≥ 0.10
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) — required for icons in the tabline, statusline, and dashboard
- A terminal with [true color](https://github.com/termstandard/colors) support

**Recommended:**

| Tool | Purpose |
|---|---|
| `ripgrep` | Live grep in pickers |
| `fd` | Faster file finding |
| `gcc` or `clang` | Treesitter parser compilation |
| `node` | Many LSP servers require it |
| `lazygit` | In-editor Git UI (`<leader>gg`) |

## Installation

### Try it alongside your current config

This clones XLVIM under a separate app name so your existing Neovim setup is untouched:

```bash
git clone https://github.com/yonasuriv/xlvim ~/.config/xlvim
NVIM_APPNAME=xlvim nvim
```

lazy.nvim bootstraps itself on the first launch and installs everything automatically.

### Make it your default config

```bash
# Optional: back up your existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone XLVIM as the default
git clone https://github.com/yonasuriv/xlvim ~/.config/nvim
nvim
```

## Features

### Dashboard

Custom XLVIM ASCII-art logo on startup, styled with the AstroDark palette — near-white header, red icons, grey menu text, and a dimmed plugin-count footer. The startup line shows `X/Y plugins loaded in XX.ZZ ms` without distracting icons.

### Buffer / Tab Bar

Built with [`heirline.nvim`](https://github.com/rebelot/heirline.nvim). Each buffer tab shows a filetype icon, the filename, a modified indicator (●), and a red close button. Tab-page numbers appear on the right when more than one Vim tab is open. When the file-explorer sidebar is open, a bold **Explorer** label fills the offset above it.

### Statusline

Built with [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim), themed to AstroDark. Sections left → right:

| Section | Contents |
|---|---|
| Left | Mode pill · Git branch · Working directory |
| Center | Filetype icon · File path · Diagnostics |
| Right | LSP progress · LSP clients · Lazy updates · Git diff |
| Far right | Cursor position · Clock (HH:MM) |

### Colorscheme

AstroDark via [`AstroNvim/astrotheme`](https://github.com/AstroNvim/astrotheme). Highlight overrides — including all dashboard colors — live in `lua/plugins/colorscheme.lua` under `highlights.global`, so they apply on top of the theme without patching it.

### Completion

[`blink.cmp`](https://github.com/saghen/blink.cmp) with documentation auto-shown after a short delay.

## File Layout

```
xlvim/
├── init.lua                    # Neovim entry point
├── lazyvim.json                # LazyVim plugin selection lock
├── scripts/
│   └── sync-xlvim-config.sh   # Dev helper: sync working dir → ~/.config/xlvim
└── lua/
    ├── config/
    │   ├── lazy.lua            # lazy.nvim bootstrap + plugin spec imports
    │   ├── options.lua         # Neovim option overrides (tabline, statusline)
    │   ├── keymaps.lua         # Personal keymaps
    │   └── autocmds.lua        # Personal autocommands
    └── plugins/
        ├── colorscheme.lua     # AstroDark theme + highlight overrides
        ├── dashboard.lua       # Snacks dashboard (logo, menu items, startup line)
        ├── statusline.lua      # Lualine statusline configuration
        ├── tabline.lua         # Heirline buffer/tab bar
        └── completion.lua      # Blink.cmp completion settings
```

## Customizing

The short version:

- **Add a plugin** — drop a `.lua` spec in `lua/plugins/`. lazy.nvim picks it up automatically.
- **Override a plugin** — use the same plugin name in a new file; lazy.nvim deep-merges the opts.
- **Keymaps** — add to `lua/config/keymaps.lua`.
- **Autocommands** — add to `lua/config/autocmds.lua`.
- **LazyVim extras** — run `:LazyExtras` to browse and enable language/tool support packs.

See **[docs/configuration.md](docs/configuration.md)** for a full walkthrough.

## Development Workflow

When iterating on the config from a working directory (e.g., `~/Desktop/xlvim`) while testing via `NVIM_APPNAME=xlvim nvim`, use the sync script to keep the deployed copy up to date:

```bash
# One-time copy
bash scripts/sync-xlvim-config.sh

# Watch for changes and re-copy automatically
bash scripts/sync-xlvim-config.sh --watch
```

See **[docs/development.md](docs/development.md)** for the full dev workflow.

## Credits

- [LazyVim](https://github.com/LazyVim/LazyVim) by [@folke](https://github.com/folke) — plugin foundation and best-in-class defaults
- [AstroNvim](https://github.com/AstroNvim/AstroNvim) — AstroDark colorscheme and tabline design language
- [NvChad](https://github.com/NvChad/NvChad) — statusline layout inspiration

## License

MIT — see [LICENSE](./LICENSE).
