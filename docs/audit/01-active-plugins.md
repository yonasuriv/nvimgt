# Audit: Active Runtime Plugins & Config

**Scope:** Files loaded via `init.lua` → `nvimgt.config.lazy` → `{ import = "nvimgt.plugins" }`.

## Load chain

```
init.lua
  ├─ package.preload["config.*"] → nvimgt.config.*
  └─ nvimgt.config.lazy
       ├─ lazyvim.plugins (LazyVim distribution)
       └─ nvimgt.plugins (one-level scan)
            ├─ colorscheme.lua
            ├─ completion.lua
            ├─ dashboard.lua
            ├─ review/init.lua      ← DUPLICATE (should not be here)
            ├─ lsp/init.lua         ← DUPLICATE (should not be here)
            ├─ statusline.lua
            └─ tabline.lua
```

## Per-file findings

### `init.lua` — KEEP

Preload shim maps LazyVim's `config.*` requires to `nvimgt.config.*`. Correct.

### `config/lazy.lua` — KEEP

Bootstraps lazy.nvim; imports LazyVim + nvimgt plugins. Comment "LazyVim distribution" is attribution, not user-facing.

### `config/options.lua` — KEEP

Sets `laststatus = 3`, `showtabline = 2` for statusline/tabline.

### `config/keymaps.lua` — KEEP (empty)

Personal keymaps placeholder. Useful maps stuck in orphan `mappings.lua`.

### `config/autocmds.lua` — KEEP (empty)

### `plugins/colorscheme.lua` — KEEP

AstroDark + dashboard highlight overrides. Second spec sets LazyVim `opts.colorscheme = "astrodark"`.

### `plugins/dashboard.lua` — KEEP

Custom nvimGT ASCII header, startup stats line, explorer title cleared in picker.

### `plugins/completion.lua` — KEEP

blink.cmp documentation auto-show.

### `plugins/statusline.lua` — KEEP, minor fixes

- Truncated header comment
- Uses `LazyVim.config.icons`, `LazyVim.lualine.pretty_path()` (API — OK while LazyVim is base)
- Custom gitsigns diff source needs comment
- Overlaps `review/ui.lua` if that were ever enabled

### `plugins/tabline.lua` — KEEP

Disables bufferline; heirline tabline with Explorer offset. Well-commented.

### `health.lua` — KEEP, rebrand

User-visible sections say "LazyVim" → should say "nvimGT".

### `types.lua` — KEEP

`---@meta` only; sets `_G.LazyVim` for IDE stubs.

## Active conflicts (resolved or latent)

| Conflict | Status |
|----------|--------|
| bufferline vs heirline | Resolved — bufferline disabled in tabline.lua |
| lualine vs review/ui.lua | Latent — review/ui not loaded (sibling file) |
| snacks dashboard vs review/ui.lua | Latent — review/init.lua loads but ui.lua does not |
| colorscheme triple-set | OK — all target astrodark |

## Catppuccin

None in active files.

## Branding (user-visible)

| File | Issue |
|------|-------|
| health.lua | Section titles "LazyVim" |
| dashboard.lua | `:LazyExtras` action — upstream command name (acceptable) |

## Orphan config files (not active)

See [05-folder-structure.md](./05-folder-structure.md) — 9 misplaced files in `config/`.
