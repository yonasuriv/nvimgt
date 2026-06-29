<div align="center">

# nvimGT

eXtended Line-editor Visual Improved Mode

</div>

## Description

nvimGT is a fast, aesthetic Neovim **distribution** with its own UI (NvChad/ui, base46, Snacks dashboard) and lazyload-first plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim). It **includes [LazyVim](https://github.com/LazyVim/LazyVim)** for LSP, Mason, and optional language/tool extras (`:extras`) — LazyVim is supported, not a fork to delete.

## Requirements

- **Neovim** ≥ 0.11.2
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) — recommended for icons to render properly
- A terminal with [true color](https://github.com/termstandard/colors) support

**Recommended tools:** `ripgrep`, `fd`, `gcc`/`clang`, `node`, `lazygit`

## Installation

### Try alongside your current config

```bash
git clone https://github.com/yonasuriv/nvimgt ~/.config/nvimgt
NVIM_APPNAME=nvimgt nvim
```

lazy.nvim bootstraps on first launch and installs plugins automatically.

### Make it your default config

```bash
mv ~/.config/nvim ~/.config/nvim.bak   # optional backup
git clone https://github.com/yonasuriv/nvimgt ~/.config/nvim
nvim
```

## Features

### Dashboard

Custom nvimGT ASCII logo on startup (AstroDark palette). Startup line shows `X/Y plugins loaded in XX.ZZ ms`.

### Buffer / tab bar

[NvChad/ui](https://github.com/NvChad/ui) **tabufline** — per-tab buffers, file icons, theme toggle, and explorer offset (Snacks / neo-tree). Configure in `lua/chadrc.lua`.

### Statusline

[NvChad/ui](https://github.com/NvChad/ui) statusline (`default` theme). Theme and modules in `lua/chadrc.lua`; highlights from [base46](https://github.com/NvChad/base46).

### Colorscheme

**AstroDark** via custom base46 theme (`lua/themes/astrodark.lua`). Toggle light/dark with tabufline theme button or `:theme`. Dashboard palette in `chadrc.lua` `hl_override`.

### Completion

[blink.cmp](https://github.com/saghen/blink.cmp) with auto-shown documentation.

### Commands

| Command | Action |
|---------|--------|
| `:cheatsheet` | NvChad keymap cheatsheet |
| `:theme` | base46 theme picker (catppuccin excluded) |
| `:extras` | LazyVim optional packs |
| `:reload` | Reset shipped `config.json` extras state |

### Extras & config state

Shipped **`config.json`** at the config root stores LazyVim extras toggles (not `lazyvim.json` — path is set via `vim.g.lazyvim_json` in `init.lua`). To start fresh: `:reload`, restart, or delete `config.json`.

## Customizing

- **Plugins** — add specs in `lua/nvimgt/plugins/`
- **Keymaps** — `lua/nvimgt/config/keymaps.lua`
- **UI / themes** — `lua/chadrc.lua`, `lua/themes/`
- **Guide** — [docs/spec/configuration.md](docs/spec/configuration.md)
- **Architecture** — [docs/spec/architecture.md](docs/spec/architecture.md)
- **Audit** — [docs/audit/00-summary.md](docs/audit/00-summary.md)

## Development

```bash
bash scripts/sync-nvimgt.sh --watch
NVIM_APPNAME=nvimgt nvim
```

See [docs/spec/development.md](docs/spec/development.md).

## Credits

Inspired by and built with patterns from:

- [LazyVim](https://github.com/LazyVim/LazyVim) — base plugin specs and extras system
- [AstroNvim](https://github.com/AstroNvim/AstroNvim) — AstroDark theme
- [NvChad](https://github.com/NvChad/NvChad) — keymap and UI patterns (salvaged where noted)

New to Neovim config? See [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## License

MIT — see [LICENSE](./LICENSE).
