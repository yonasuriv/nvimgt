<div align="center">

# nvimGT

eXtended Line-editor Visual Improved Mode

</div>

## Description

nvimGT is a fast, aesthetic Neovim configuration with a refined UI, strong defaults, and lazyload-first plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim). It includes [LazyVim](https://github.com/LazyVim/LazyVim) support for LSP, extras, and core plugin specs.

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

[heirline.nvim](https://github.com/rebelot/heirline.nvim) tabline with file icons, modified indicator, and close button. Bold **Explorer** label fills the offset above the sidebar.

### Statusline

[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — mode, git, cwd, diagnostics, LSP, lazyload updates, git diff, progress, clock.

### Colorscheme

AstroDark via [astrotheme](https://github.com/AstroNvim/astrotheme). Dashboard highlights in `lua/nvimgt/plugins/colorscheme.lua`.

### Completion

[blink.cmp](https://github.com/saghen/blink.cmp) with auto-shown documentation.

## Customizing

- **Plugins** — add specs in `lua/nvimgt/plugins/`
- **Keymaps** — `lua/nvimgt/config/keymaps.lua`
- **Extras** — `:extras` (LazyVim packs; state in shipped `config.json`)
- **Reset extras** — `:NvimgtFresh` then restart (or delete `config.json`)
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
