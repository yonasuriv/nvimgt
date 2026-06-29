# TODO

## Observations

### LazyVim distribution layer

nvimGT **ships its own UI core** (NvChad/ui + base46 + Snacks dashboard) and **imports [LazyVim](https://github.com/LazyVim/LazyVim)** for LSP, Mason, extras (`:extras`), and optional language packs. LazyVim is supported, not replaced — document this for users choosing `:extras`.

### `config.json` vs `lazyvim.json`

LazyVim defaults to `lazyvim.json` at the config root (`vim.g.lazyvim_json` in upstream). nvimGT sets `vim.g.lazyvim_json` in `init.lua` to **`config.json`** instead — no symlink required. A shipped `config.json` is committed to the repo (empty extras). Users who want factory extras state: **`:reload`** then restart (or delete `config.json` manually). Legacy `lazyvim.json` remains in `.gitignore` if created by mistake.

### Root dotfiles (2026-06-29)

All six project-root dotfiles are necessary and non-duplicative: `.editorconfig`, `.stylua.toml`, `.selene.toml`, `.neoconf.json`, `.markdownlint.yaml`, `.gitignore`. See `docs/audit/07-dotfiles.md`. No `plugins.json`; no duplicate `stylua.toml` (without dot).

### nvimGT core vs NvChad upstream checklist

| Area | nvimGT ships | Notes |
|------|----------------|-------|
| NvChad UI (statusline, tabufline, cheatsheet, term hide) | Yes | `:cheatsheet`, tabufline theme btn |
| base46 + theme picker | Yes | `:theme`; custom `astrodark` / `astrolight`; catppuccin excluded from picker |
| Dashboard cheatsheet + themes | Yes | dashboard `h`/`t`/`l`; global `t` = theme |
| gitsigns, mason, lspconfig, treesitter, which-key | Yes | LazyVim + nvimgt overrides |
| nvim-web-devicons | Yes | NvChad tabufline + LazyVim mini.icons mock |
| friendly-snippets | Yes | blink.cmp dependency |
| nvim-tree, telescope, nvim-cmp, nvim-autopairs, indent-blankline, LuaSnip | No (by design) | LazyVim defaults: Snacks picker/explorer, blink.cmp, mini.pairs, Snacks indent; enable extras if needed |

### LSP semantic tokens (from NvChad `lspconfig.lua` salvage)

The old NvChad `lspconfig.lua` disabled **LSP semantic tokens** (`textDocument/semanticTokens`) on attach. Some themes handle semantic highlighting poorly; disabling it keeps colors from Treesitter + AstroDark only.

**Status:** Not ported yet — LazyVim defaults may already handle this per server.

**Action when needed:** Add `lua/nvimgt/plugins/lsp-overrides.lua` with an `on_init` hook that clears `semanticTokensProvider` if colors look double-highlighted or clash with AstroDark.

**Decision:** Observe first; port only if a real visual issue appears.
