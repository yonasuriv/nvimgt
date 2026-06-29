# Development Workflow

## Setup

```bash
git clone https://github.com/yonasuriv/nvimgt ~/Desktop/nvimgt
```

Deployed config: `~/.config/nvimgt` via `NVIM_APPNAME=nvimgt nvim`.

## Sync script

`scripts/sync.sh` copies the working tree to `~/.config/nvimgt`:

```bash
bash scripts/sync.sh
bash scripts/sync.sh --watch   # requires watchdog
```

## Testing

```bash
NVIM_APPNAME=nvimgt nvim
NVIM_APPNAME=nvimgt nvim --headless -c "qa" 2>&1   # no output = clean start
```

## In-editor commands

| Command | Purpose |
|---------|---------|
| `:lazy` / `:Lazy` | lazy.nvim plugin manager |
| `:extras` / `:LazyExtras` | Toggle upstream LazyVim extras |
| `:die` / `:bye` / `:qa` | Quit (`:die!` / `:bye!` = `:qa!`) |
| `:reload` | Delete `config.json` to reset extras (restart after) |
| `t` | Theme picker (normal mode) |
| `<leader>e` / `<C-n>` | Open file explorer |
| `:checkhealth nvimgt` | nvimGT health checks |
| `:LspInfo` | Active LSP clients |

**How aliases work:** `lua/nvimgt/utils/commands.lua` is the single implementation. Typing `:lazy` at the `:` prompt uses a cmdline abbreviation (`lazy` → `Lazy`). Dashboard keys call the same module via `:lua require('nvimgt.utils.commands').lazy()` etc. `:Lazy` / `:LazyExtras` still work as upstream names.

## Project structure

```
nvimgt/
├── init.lua
├── config.json                 # Shipped extras state (LazyVim; reset with :reload)
├── .stylua.toml
├── reference/lazyvim/       # upstream snapshots (not loaded)
├── scripts/
│   ├── install.sh
│   └── sync.sh
├── docs/
│   ├── architecture.md
│   ├── configuration.md
│   ├── development.md
│   └── audit/               # repo audits
└── lua/nvimgt/
    ├── config/
    │   ├── lazy.lua         # lazy.nvim bootstrap
    │   ├── theme.lua        # NvChad UI + base46 theme
    │   ├── options.lua
    │   ├── keymaps.lua
    │   └── autocmds.lua
    └── plugins/
        ├── colorscheme.lua
        ├── completion.lua
        ├── dashboard.lua
        ├── gitsigns.lua
        ├── mason.lua
        ├── ui.lua
        ├── colorscheme.lua
        └── treesitter.lua
```

## Code style

```bash
stylua lua/
```

Config: `.stylua.toml`.

## Pitfalls

- **Array opts replace** — full `keys` / `sections` lists when overriding Snacks or lualine.
- **Heirline `hl`** — use highlight group name string or `{ fg = "#hex" }`, not `{ fg = "GroupName" }`.
