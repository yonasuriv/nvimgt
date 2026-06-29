# Development Workflow

This document covers the recommended workflow for iterating on the XLVIM config itself.

## Setup

Clone the repo to a working directory separate from your deployed config:

```bash
git clone https://github.com/yonasuriv/xlvim ~/Desktop/xlvim
```

The deployed config lives at `~/.config/xlvim` and is what `NVIM_APPNAME=xlvim nvim` reads. Keep the two in sync using the sync script (see below).

## Sync Script

`scripts/sync-xlvim-config.sh` uses `rsync` to copy changes from the working directory to the deployed location.

Run from the repo root:

```bash
# Copy once
bash scripts/sync-xlvim-config.sh

# Watch for file changes and copy automatically (requires watchdog)
bash scripts/sync-xlvim-config.sh --watch
```

The `--watch` mode requires [`watchdog`](https://pypi.org/project/watchdog/) (`pip install watchdog`), which ships the `watchmedo` CLI. It monitors `*.lua`, `*.vim`, `*.toml`, `*.json`, and `*.md` files recursively and triggers a sync on any change.

Files excluded from sync: `.git/`, swap files (`*.swp`), and editor backup files (`*~`).

## Testing Changes

After syncing, launch Neovim with the XLVIM app name:

```bash
NVIM_APPNAME=xlvim nvim
```

To check for startup errors without opening the UI:

```bash
NVIM_APPNAME=xlvim nvim --headless -c "qa" 2>&1
```

A clean run produces no output. Any Lua errors or missing module warnings will be printed to stderr.

## Checking Plugin State

Inside Neovim:

| Command | What it shows |
|---|---|
| `:Lazy` | Plugin manager UI — installed plugins, load times, errors |
| `:LazyExtras` | Browse and toggle LazyVim language/tool extras |
| `:checkhealth` | System dependencies (LSPs, tools, providers) |
| `:LspInfo` | Active LSP clients for the current buffer |
| `:Lazy log` | Recent plugin update changelog |

## Project Structure

```
xlvim/
├── init.lua                    # Neovim entry point — do not edit
├── lazyvim.json                # Tracks which LazyVim extras are enabled
├── stylua.toml                 # StyLua formatter config for Lua files
├── scripts/
│   └── sync-xlvim-config.sh   # Dev sync helper
├── docs/
│   ├── configuration.md        # Full configuration guide
│   └── development.md          # This file
└── lua/
    ├── config/
    │   ├── lazy.lua            # Bootstrap and plugin spec imports
    │   ├── options.lua         # vim.opt overrides
    │   ├── keymaps.lua         # Personal keymaps
    │   └── autocmds.lua        # Personal autocommands
    └── plugins/
        ├── colorscheme.lua     # AstroDark + highlight overrides
        ├── dashboard.lua       # Snacks dashboard
        ├── statusline.lua      # Lualine statusline
        ├── tabline.lua         # Heirline tabline
        └── completion.lua      # Blink.cmp
```

## Code Style

Lua files are formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua). Configuration is in `stylua.toml`. Format before committing:

```bash
stylua lua/
```

## Common Pitfalls

**Icon characters getting stripped** — Nerd Font codepoints (e.g., ``) can be silently lost when copying through an editor or terminal. Always verify icon bytes with a hex tool rather than trusting what you see on screen. The safe approach is to write files via a script that uses the explicit Unicode code points.

**Heirline `hl` must be a string or hex table** — Passing a highlight group name as the value of `fg` (e.g., `{ fg = "DiagnosticError" }`) is invalid. Either return the group name as a string, or resolve it to a hex color: `utils.get_highlight("DiagnosticError").fg`.

**Snacks color lookups at setup time** — `Snacks.util.color("Group")` must be inside a `function()` when used as a lualine color, otherwise it runs before Snacks is ready and returns nil.

**Array opts are replaced, not merged** — In lazy.nvim, if you set `sections = { ... }` or `keys = { ... }` in your spec, the entire array replaces the default. Provide the full list, not just the items you want to change.
