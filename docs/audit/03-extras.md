# Audit: `plugins/extras/` (115 files)

## Summary

**Entire tree is dead code** — not discovered by lazy.nvim import scanner. Byte-identical to LazyVim upstream. Zero `nvimgt.plugins.extras.*` references.

## Why not loaded

1. `lazy.core.util.lsmod` scans **one level** under `nvimgt.plugins`.
2. No `extras/init.lua` at the extras root.
3. `:LazyExtras` UI sources: `lazyvim.plugins.extras` + `plugins.extras` (user), not `nvimgt.plugins.extras`.

## Inventory

| Category | Files |
|----------|------:|
| lang/ | 53 |
| editor/ | 18 |
| util/ | 9 |
| ui/ | 9 |
| ai/ | 9 |
| coding/ | 8 |
| lsp/ | 2 |
| formatting/ | 2 |
| dap/ | 2 |
| linting/ | 1 |
| test/ | 1 |
| root | 1 (`vscode.lua`) |
| **Total** | **115** |

## Correct folder if customized extras are wanted

```
lua/plugins/extras/<category>/<name>.lua   # LazyVim "User extras"
```

NOT `lua/nvimgt/plugins/extras/`.

## Conflict risks (if enabled via :LazyExtras upstream)

| Area | Active nvimGT | Conflicting extra |
|------|---------------|-------------------|
| Dashboard | snacks (`dashboard.lua`) | `ui.alpha`, `ui.dashboard-nvim`, `ui.mini-starter` |
| Picker | snacks_picker (LazyVim default) | `editor.telescope`, `editor.fzf` |
| Completion | blink (`completion.lua`) | `coding.nvim-cmp` |
| Explorer | snacks_explorer | `editor.neo-tree` (optional coexistence) |

## Catppuccin

| File | Usage |
|------|-------|
| `extras/coding/blink.lua` | Optional catppuccin integration |
| `extras/editor/overseer.lua` | Optional catppuccin integration |

Both `optional = true`. Inert with AstroDark unless user installs catppuccin and enables those extras.

## `lazyvim.plugins.extras.*` references inside dead copies

8 cross-imports (e.g. `vue.lua` → `lang.typescript`). Valid when loaded from **upstream** LazyVim, irrelevant for local copies.

## Recommendation

Delete or move to `reference/lazyvim/plugins/extras/`. Use `:LazyExtras` for runtime toggling.
