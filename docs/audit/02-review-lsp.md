# Audit: `plugins/review/` and `plugins/lsp/`

## Summary

Vendored LazyVim copies. **Two `init.lua` files are loaded** and duplicate upstream specs. **Nine sibling files are never loaded** (lazy.nvim only scans one directory level).

## Inventory

| File | Loaded? | Lines | Identity vs upstream |
|------|---------|------:|----------------------|
| `review/init.lua` | **YES** | 32 | Identical to `lazyvim/plugins/init.lua` |
| `review/ui.lua` | No | 330 | Copy |
| `review/coding.lua` | No | 89 | Copy |
| `review/editor.lua` | No | 271 | Copy |
| `review/formatting.lua` | No | 100 | Copy |
| `review/linting.lua` | No | 101 | Copy |
| `review/treesitter.lua` | No | 214 | Copy |
| `review/util.lua` | No | 58 | Copy |
| `review/xtras.lua` | No | 81 | Copy |
| `lsp/init.lua` | **YES** | 318 | Identical to `lazyvim/plugins/lsp/init.lua` |
| `lsp/keymaps.lua` | No | 67 | Library module, not a spec |

## Folder placement

| File | Should be |
|------|-----------|
| All `review/*` | `reference/lazyvim/plugins/` — not under rtp `plugins/` |
| `lsp/keymaps.lua` | `nvimgt/utils/lsp/keymaps.lua` if forked; else delete (upstream used at runtime) |

## Conflict matrix

| Scenario | Risk |
|----------|------|
| Current: `review/init.lua` + `lsp/init.lua` loaded | Medium — redundant specs, double `lazyvim.config.init()` |
| Enable `review/ui.lua` at top level | **High** — fights statusline.lua + tabline.lua |
| Enable `review/xtras.lua` at top level | **High** — double extras imports |
| Delete both init.lua files | **Low** — upstream LazyVim still provides identical specs |

## LazyVim API usage

45+ `LazyVim.*` calls across these files. No migration needed while LazyVim remains the distribution (see Q1 in [00-summary.md](./00-summary.md)).

## Catppuccin

None in review/ or lsp/.
