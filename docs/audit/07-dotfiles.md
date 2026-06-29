# Root dotfiles audit

**Date:** 2026-06-29 (post-cleanup)

## Summary

| File | Necessary? | Referenced by | Verdict |
|------|------------|---------------|---------|
| `.editorconfig` | Yes | Editors (VS Code, Cursor, etc.) | **KEEP** — UTF-8, 2-space indent |
| `.stylua.toml` | Yes | `CONTRIBUTING.md`, `docs/development.md`, `stylua lua/` | **KEEP** — Lua formatter config |
| `.selene.toml` | Optional | Local lint only (no CI) | **KEEP** — Lua linter if you use Selene |
| `.neoconf.json` | Yes | [neoconf.nvim](https://github.com/folke/neoconf.nvim) / `lua_ls` workspace | **KEEP** — LSP workspace library settings |
| `.markdownlint.yaml` | Optional | Local markdown lint only | **KEEP** — harmless; disable MD013/MD033 |
| `.gitignore` | Yes | Git | **KEEP** — updated (see below) |
| `.vim.yml` | No | Nothing in repo | **REMOVED** — was unused Selene/vim-linter globals; `.selene.toml` `std="vim"` covers Neovim |

## Removed / fixed stale references

| Item | Was | Now |
|------|-----|-----|
| `plugins.json` | In `.gitignore`, mentioned in old docs | **Removed** — never existed; LazyVim uses `config.json` via `vim.g.lazyvim_json` |
| `lazyvim.json` | Gitignored | **Still gitignored** — legacy name; nvimGT uses committed `config.json` instead |
| `stylua.toml` (no dot) | Old superpowers docs | **Stale** — actual file is `.stylua.toml` |
| `docs/superpowers/` | Pre-`nvimgt/` namespace plans | **Stale** — archive only; not linked from README |

## `config.json` (not a dotfile)

| Aspect | Detail |
|--------|--------|
| Purpose | LazyVim extras state (enabled language/tool packs) |
| Path | Set in `init.lua` via `vim.g.lazyvim_json` — **not hardcoded** to `lazyvim.json` |
| Shipped | Committed at repo root; synced to `~/.config/nvimgt/config.json` |
| Reset | `:NvimgtFresh` then restart, or delete `config.json` manually |

## No duplicates

Each remaining dotfile serves a distinct tool (editor, StyLua, Selene, neoconf, markdownlint, git). No overlapping config between them after `.vim.yml` removal.
