# LazyVim upstream snapshots

This directory holds **reference copies** of LazyVim plugin specs. These files are **not on Neovim's runtime path** and are never loaded.

## Contents

| Path | Files | Purpose |
|------|------:|---------|
| `plugins/review/` | 9 | LazyVim core plugin specs (`init.lua`, `ui.lua`, `xtras.lua`, …) |
| `plugins/lsp/` | 2 | LazyVim LSP stack + keymaps helper |
| `plugins/extras/` | 115 | LazyVim optional extras (lang, editor, ui, …) |

## Why not under `lua/nvimgt/plugins/`?

lazy.nvim auto-imports any `*/init.lua` under `nvimgt.plugins`, which caused **duplicate** spec registration. Extras under `nvimgt/plugins/extras/` were also **never discovered** (one-level import scan).

## How to enable extras at runtime

Use **`:LazyExtras`** — toggles load from the installed **LazyVim** plugin (`lazyvim.plugins.extras.*`), not from this folder.

Custom nvimGT extras belong in `lua/plugins/extras/` (LazyVim "User extras" path).

## Credits

Upstream: [LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) — MIT License.
