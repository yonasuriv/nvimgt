<div align="center" id="madewithlua">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset=".github/assets/nvimgt-dark.png">
    <source media="(prefers-color-scheme: white)" srcset=".github/assets/nvimgt-white.png">
    <img src=".github/assets/nvimgt-dark.png" alt="nvimGT">
  </picture>
</div>

## Description

nvimGT is a blazing fast, aesthetic and extensible neovim configuration with a refined UI, strong defaults, and a carefully selected plugin set designed for a smooth out-of-the-box experience.

## Requirements

- **Neovim** ≥ 0.10
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) — optional but heavily recommended for icons tp render properly.
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

This clones nvimGT under a separate app name so your existing Neovim setup is untouched:

```bash
git clone https://github.com/yonasuriv/nvimgt ~/.config/nvimgt
NVIM_APPNAME=nvimgt nvim
```

lazy.nvim bootstraps itself on the first launch and installs everything automatically.

### Make it your default config

```bash
# Optional: back up your existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone nvimGT as the default
git clone https://github.com/yonasuriv/nvimgt ~/.config/nvim
nvim
```

## Features

### Dashboard

Custom nvimGT ASCII-art logo on startup, styled with the AstroDark palette — near-white header, red icons, grey menu text, and a dimmed plugin-count footer. The startup line shows `X/Y plugins loaded in XX.ZZ ms` without distracting icons.

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
nvimgt/
├── init.lua                    # Neovim entry point
├── plugins.json                # Plugin selection lock
├── scripts/
│   └── sync-nvimgt-config.sh   # Dev helper: sync working dir → ~/.config/nvimgt
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

When iterating on the config from a working directory (e.g., this cloned repo) while testing via `NVIM_APPNAME=nvimgt nvim`, use the sync script to keep the deployed copy up to date:

```bash
# One-time copy
bash scripts/sync-nvimgt-config.sh

# Watch for changes and re-copy automatically
bash scripts/sync-nvimgt-config.sh --watch
```

See **[docs/development.md](docs/development.md)** for the full dev workflow.

## Credits

This work was heavily inspired from the following repositories:

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- [NvChad](https://github.com/NvChad/NvChad)

Want to create your own personal nvim configuration? Take a look at [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) repo.

## License

MIT — see [LICENSE](./LICENSE).
