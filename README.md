<div align="center" id="madewithlua">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset=".github/assets/nvimgt-dark.png">
    <source media="(prefers-color-scheme: white)" srcset=".github/assets/nvimgt-white.png">
    <img src=".github/assets/nvimgt-dark.png" alt="nvimGT">
  </picture>
</div>

## Description

nvimGT is a fast, aesthetic, and extensible Neovim distribution with a refined UI, strong defaults, and a carefully selected plugin set. It is designed to provide a smooth out-of-the-box experience with lazy-load-first plugin management powered by [lazy.nvim](https://github.com/folke/lazy.nvim), while supporting the broader LazyVim plugin ecosystem. 

> [!NOTE]
> This project started as a personal experiment after years of working with [Overleaf](https://github.com/overleaf/overleaf), Lua, LaTeX, and LuaLaTeX-based editing workflows. \
> It is derived from and inspired by the work of [LazyVim](https://github.com/LazyVim/LazyVim), [AstronNvim](https://github.com/astronvim/astronvim) and [NvChad](https://github.com/NvChad/NvChad).
>
> nvimGT should be treated as a personal Neovim configuration distribution. It is not intended to replace, supersede, or diminish any of the projects it builds on or takes inspiration from.

> New to Neovim config? See [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Features

### Plugin stack

nvimGT ships with a curated plugin stack focused on speed, aesthetics, and practical defaults.

- **Themes and UI**
  - Large theme collection and theme toggler, derived from [AstroNvim](https://github.com/AstroNvim/AstroNvim) and [NvChad base46](https://github.com/NvChad/base46)
  - Lightweight, performant UI layer derived from [NvChad UI](https://github.com/NvChad/ui), including statusline modules, tabufline, cheatsheets, terminal buffer controls, updater, theme switcher, and more
  - Beautiful, configurable icons with [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

- **Navigation and search**
  - File explorer powered by [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
  - Fuzzy finding, file preview, text search, and more with [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

- **Git integration**
  - Inline Git signs, hunks, blame, and diff utilities with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)

- **LSP and completion**
  - Neovim LSP configuration with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
  - LSP, formatter, linter, and debugger management with [mason.nvim](https://github.com/williamboman/mason.nvim)
  - Autocompletion with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) and [blink.cmp](https://github.com/saghen/blink.cmp), including auto-shown documentation

- **Editing experience**
  - Syntax highlighting and code parsing with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - Auto-closing brackets, quotes, and HTML tags with [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
  - Indentation guides with [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
  - Useful snippets from [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), powered by [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

- **Keymaps and extensions**
  - Popup keymap hints with [which-key.nvim](https://github.com/folke/which-key.nvim)
  - LazyVim Extras compatibility through [LazyVim](https://github.com/LazyVim/LazyVim)

### Commands

| Command / key | Action |
|---------------|--------|
| `:menu` | Lazy plugin manager |
| `:theme` | base46 theme picker |
| `:extras` | LazyVim optional packs |
| `:reload` | Reset shipped `config.json` extras state |
| `:cheatsheet` | NvChad keymap cheatsheet |
| `<leader>e` / `<C-n>` | Open file explorer |

> **Never get stuck again**: use `:bye` or `:die` to exit nvim instantly. \
> Both are aliases for `:qa!`, which quits all windows without saving.

## Getting Started

### Requirements

- **Neovim** ≥ 0.11.2
- **Git**
- A [Nerd Font](https://www.nerdfonts.com/) — recommended for icons to render properly
- A terminal with [true color](https://github.com/termstandard/colors) support

**Recommended:**

| Tool | Purpose |
|---|---|
| `ripgrep` | Live grep in pickers |
| `fd` | Faster file finding |
| `gcc` or `clang` | Treesitter parser compilation |
| `node` | Many LSP servers require it |
| `lazygit` | In-editor Git UI (`<leader>gg`) |

### Installation

You can install **nvimGT** in one line (recommended), or manually.

#### Quick install (curl)

Installs to `~/.config/nvimgt`, adds a `nvimgt` shell alias, and bootstraps plugins. Your existing `~/.config/nvim` is left untouched.

```bash
curl -fsSL https://raw.githubusercontent.com/yonasuriv/nvimGT/refs/heads/main/scripts/install.sh | bash
```

Then open a new shell (or `source ~/.zshrc`) and run:

```bash
nvimgt
```

Skip plugin bootstrap: `NVIMGT_SKIP_PLUGINS=1 curl -fsSL … | bash`

#### 1. Try it without touching your current Neovim config

This installs nvimGT under a separate app name, so your existing `~/.config/nvim` setup stays untouched.

```bash
git clone https://github.com/yonasuriv/nvimGT ~/.config/nvimgt
NVIM_APPNAME=nvimgt nvim
```

`lazy.nvim` will bootstrap automatically on first launch and install the required plugins.

#### 2. Use it alongside other Neovim configs

Install nvimGT as a separate Neovim app and create a dedicated command for it.

```bash
git clone https://github.com/yonasuriv/nvimGT ~/.config/nvimgt
alias nvimgt='NVIM_APPNAME=nvimgt nvim'
```

To make the alias permanent, add it to your shell config:

- For Bash:

```bash
echo "alias nvimgt='NVIM_APPNAME=nvimgt nvim'" >> ~/.bashrc
```

- For Zsh:

```bash
echo "alias nvimgt='NVIM_APPNAME=nvimgt nvim'" >> ~/.zshrc
```

Then run:

```bash
nvimgt
```

#### 3. Make it your default Neovim config

1. Back up your current Neovim config (if you do not already have a Neovim config, you can skip this step)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. Clone nvimGT as your default configuration.

```
git clone https://github.com/yonasuriv/nvimGT ~/.config/nvim
```

Launch nvim normally using nvimGT under the hood:

```bash
nvim
```

## Customizing

The short version:

- **Plugins** — add specs in `lua/nvimgt/plugins/`. lazy.nvim picks it up automatically.
  - **Override a plugin** — use the same plugin name in a new file; lazy.nvim deep-merges the opts.
- **Keymaps** —  add to `lua/nvimgt/config/keymaps.lua`
- **Autocommands** — add to `lua/config/autocmds.lua`.
- **UI / themes** — add to `lua/themes/`, main config in `lua/nvimgt/config/theme.lua`
- **Extras** — run `:extras` to browse and enable lazyvim extras and language/tool support packs.

## Development

When iterating on nvimGT from a cloned repository, use the sync script to copy changes into the active `NVIM_APPNAME=nvimgt` config.

```bash
# One-time sync
bash scripts/sync.sh

# Auto-sync on file changes
bash scripts/sync.sh --watch
```

Then test with:

```
NVIM_APPNAME=nvimgt nvim # or nvimgt if you've set up the alias
```

## File Layout

```
nvimgt/
├── init.lua                    # Neovim entry point
├── config.json                 # Plugin selection lock
├── scripts/
│   ├── install.sh              # curl | bash installer
│   └── sync.sh                 # Dev helper: sync working dir → ~/.config/nvimgt
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

## Documentation

- [Architecture](docs/spec/architecture.md)
- [Configuration](docs/spec/configuration.md)
- [Development](docs/spec/development.md)

### Recommended resources

- [lazy.nvim Docs](https://lazy.folke.io/)
- [LazyVim Docs](https://www.lazyvim.org/)
- [AstroNvim Docs](https://docs.astronvim.com/)
- [NvChad Docs](https://nvchad.com/docs/config/walkthrough)

## License

MIT — see [LICENSE](./LICENSE).
